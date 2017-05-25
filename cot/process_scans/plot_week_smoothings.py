import itertools
import subprocess
import sys

from freq_channelnr_map import map_ as channelnr_map

from plot_rssi import savitzky_golay as savitzky_golay

#rename 's/...$//' *

counter = 0
maxes = []
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches


def process_point(day, hour, minute):
    signals = []  # Fill with every nf+rssi of dump
    file_name = directory + ('/' if not directory.endswith('/') else '') + day + '_' + str(hour).zfill(2) + '-' + str(
        minute).zfill(2)

    signalstr = subprocess.check_output(
        ['./fft_get_max_rssi.out', file_name]) if not channel_number else subprocess.check_output(
        ['./fft_get_max_rssi.out', file_name, channelnr_map[channel_number]])
    for line in signalstr.splitlines():
        signals.append(int(line))
    signals.sort()
    signals.reverse()

    if (len(signals) == 0):
        print(file_name)
        print ""
    return signals[filter_num]


if __name__ == '__main__':
    if (len(sys.argv) < 9 and len(sys.argv) >= 8) :
        print("Please also supply node name at the end of command")
    print(sys.argv[8])
    colors = ["blue","green","red","cyan","magenta","yellow","black","0.75", "#788599", "#2c8e36", "#7f0043"]
    if (len(sys.argv) < 6):
        print "Usage: python plot_rssi.py dump_directory comma_separated_list_of_days first_minute filter_num channel_number [prev_day next_day]\n\
               Example: To plot for all channels on 2,3,4 May 2017, first dump at 2 minutes past the hour ignoring the top 100 results for every dump: \n\
               python plot_week_smoothings.py ../output_dir 2017-05-02,2017-05-03,2017-05-04 0 100 0 2017-05-01 2017-05-05 node_name\n\
               Note that the channel number is required: 0 means all channels\n\
               To use previous and next day's last and first hour to avoid potentially ugly results at end points.\n\
               These are only used in calculations and not actually plotted."
        exit(0)

    if len(sys.argv) == 7:
        print "Either supply both prev_day and next_day or neither"
        exit(1)

    fix_endpoints = len(sys.argv) >= 8

    directory = sys.argv[1]
    daylist = [[v] for v in sys.argv[2].split(",")]
    first_minute = int(sys.argv[3])
    filter_num = int(sys.argv[4])
    channel_number = int(sys.argv[5]) if sys.argv[5] != '0' else None

    if fix_endpoints:
        for i in range(len(daylist)):
            if (i == 0):
                daylist[i].append(sys.argv[6])
                daylist[i].append(daylist[i+1][0])
            elif (i == len(daylist) - 1):
                daylist[i].append(daylist[i-1][0])
                daylist[i].append(sys.argv[7])
            else:
                daylist[i].append(daylist[i-1][0])
                daylist[i].append(daylist[i+1][0])

    for i in range(len(daylist)):
        day      = daylist[i][0]
        prev_day = daylist[i][1]
        next_day = daylist[i][2]

        maxes = []

        if fix_endpoints:
            for (hour, minute) in itertools.product(range(20,24), range(first_minute, 60, 2)):
                max_point = process_point(prev_day, hour, minute)
                maxes.append(max_point)

        for (hour, minute) in itertools.product(range(24), range(first_minute, 60, 2)):
            max_point = process_point(day, hour, minute)
            maxes.append(max_point)

        if fix_endpoints:
            for (hour, minute) in itertools.product(range(0,4), range(first_minute, 60, 2)):
                max_point = process_point(next_day, hour, minute)
                maxes.append(max_point)
        daylist[i].append(maxes)

    x = np.linspace(0, 24, 720) if not fix_endpoints else np.linspace(-4, 28, 960)

    label_list = []

    for day in daylist:
        y = np.asarray(day[3])
        # day.append(savitzky_golay(y, 101, 3))   #Index 4
        day.append("None")
        day.append(savitzky_golay(y, 361, 3))   #Index 5
        day.append(colors[0])
        day.append(colors[0])
        colors.remove(colors[0])

        #sm1 = plt.plot(x, day[4], color=day[6])
        sm2 = plt.plot(x, day[5], color=day[7])

        label_list.append(mpatches.Patch(color=day[6], label=day[0]+ ', order 3, window size 361'))


    # Ticks at even hours
    plt.xticks(np.arange(0, 25, 2))
    # Cut off endpoints fix; only show current day
    plt.xlim([0, 24])
    plt.xlabel('Time of Day (hours)')
    plt.ylabel('Smoothed Received Signal Strength (dBm)')

    #Additional 15dBm on top for legend
    plt.ylim([plt.gca().get_ylim()[0],plt.gca().get_ylim()[1]+15])

    #plt.legend(handles=label_list,prop={'size':5})

    plt.savefig("./images/channel_specific_2.4/"+sys.argv[8]+"_"+day[0]+"_"+"chan"+str(channel_number)+"_image.png", bbox_inches='tight')
    plt.savefig("./images/channel_specific_2.4/"+sys.argv[8]+"_"+day[0]+"_"+"chan"+str(channel_number)+"_image.pdf", bbox_inches='tight')

    # plt.show()
