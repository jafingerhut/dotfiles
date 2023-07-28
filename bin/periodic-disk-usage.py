#! /usr/bin/env python3

import json
import pprint
import subprocess
import sys
import time

# Periodically get the disk usage with the `df` command, convert its
# output to JSON, insert a just-before-time and just-after-time to get
# a limit on the range of possible times that disk usage was
# retrieved, and append to an output file.

period_sec = 2

#pp = pprint.PrettyPrinter(indent=2)

while True:
    just_before_time = time.time()
    disk_usage_str = subprocess.check_output('disk-usage-json-output.sh')
    just_after_time = time.time()
    disk_usage_data = json.loads(disk_usage_str)
    my_data = {'just_before_time': just_before_time,
               'just_after_time': just_after_time,
               'disk_usage': disk_usage_data}
    #pp.pprint(my_data)
    print(my_data)
    sys.stdout.flush()
    time.sleep(period_sec)
