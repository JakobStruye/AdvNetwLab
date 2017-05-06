import itertools
import subprocess
import sys
import os.path
from freq_channelnr_map import map_ as channelnr_map
counter = 0
maxes = []

if (len(sys.argv) < 5):
    print "Usage: python plot_rssi.py dump_directory date first_minute filter_num (channel number) \n\
           Example: To plot for 1 May 2017, first dump at 2 minutes past the hour ignoring the top 100 results for every dump: \n\
           python plot_rssi.py ../output_dir 2017-05-01 2 100 \n\
           Example: To plot for channel 36 on 2 May 2017, first dump at 2 minutes past the hour ignoring the top 100 results for every dump: \n\
           python plot_rssi.py ../output_dir 2017-05-02 2 100 36"
    exit(0)

for(hour,minute) in itertools.product(range(24), range(int(sys.argv[3]),60,10)):
    channel_nr = int(sys.argv[5]) if (len(sys.argv) == 6) else 0
    signals = [] #Fill with every nf+rssi of dump
    file_name = sys.argv[1] + ('/' if not sys.argv[1].endswith('/') else '') + sys.argv[2] + '_' + str(hour).zfill(2) + '-' + str(minute).zfill(2) + '-01'
    if (not os.path.isfile(file_name)):
        #print("File " + file_name + " does not exist in the dump directory")
        continue
    signalstr = subprocess.check_output(['./fft_get_max_rssi.out', file_name]) if not channel_nr else subprocess.check_output(['./fft_get_max_rssi.out', file_name, channelnr_map[channel_nr]])
    for line in signalstr.splitlines():
        signals.append(int(line))
    signals.sort()
    signals.reverse()
    print "%d %d" % (counter, signals[int(sys.argv[4])])
    counter += 1
    maxes.append(signals[int(sys.argv[4])])
