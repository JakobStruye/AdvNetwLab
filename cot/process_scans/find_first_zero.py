import os, subprocess
import sys
from subprocess import Popen, PIPE

def f_comes_first(date1, date2):
    date1_day = int(date1.split("_")[0].split("-")[2])
    date2_day = int(date2.split("_")[0].split("-")[2])
    if (date1_day < date2_day):
        print(date1, date2)
        return True
    else:
        return False


if __name__ == "__main__":
    filename = sys.argv[1]
    currMinDate = "9999-99-99_99-99"

    with open(os.devnull, "w") as z:
        for f in os.listdir(filename):
            p = Popen(["du", filename +""+ f], stdin=PIPE, stdout=PIPE, stderr=PIPE)
            output, err = p.communicate(b"input data that is passed to subprocess' stdin")
            size = int(output[0])
            if (size == 0 and f_comes_first(f, currMinDate)):
                print(currMinDate, size)
                currMinDate = f

    print(currMinDate)
