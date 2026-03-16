#! /usr/bin/env python3

# Sometimes useful in comparing different log files against each other,
#  if they have dates/times at the start of each line.

import fileinput
import re

for line in fileinput.input():
    line = line.rstrip()
    match = re.search(r"^(\d\d-\d\d-\d\d\d\d \d\d:\d\d:\d\d\.\d+)(.*)$", line)
    if match:
        datetime = match.group(1)
        restofline = match.group(2)
        line = restofline
    print(line)
