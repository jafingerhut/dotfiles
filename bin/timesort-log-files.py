#! /usr/bin/env python3

# Author: Andy Fingerhut (jafinger@cisco,com, andy.fingerhut@gmail.com)

# Copyright 2024 Cisco Systems, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import collections
import argparse
import glob
import os
import re
import subprocess
import sys

# Parsing command line arguments

parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description="""
Take a list of log file names, typically ones that have been created
via the `logrotate` utility, and put them in an order such that the
first one should contain the oldest log messages, and the last one
contains the newest log messages.

For example, if you run the command with these parameters:

    /var/log/syslog.*

and the shell expands /var/log/syslog.* into the following list of
file names in /var/log, which have been sorted lexicographically by
comparing their strings as sequences of characters:

    /var/log/syslog.10.gz
    /var/log/syslog.11.gz
    /var/log/syslog.12.gz
    /var/log/syslog.1.gz
    /var/log/syslog.2.gz
    /var/log/syslog.3.gz
    /var/log/syslog.4.gz
    /var/log/syslog.5.gz
    /var/log/syslog.6.gz
    /var/log/syslog.7.gz
    /var/log/syslog.8.gz
    /var/log/syslog.9.gz
    /var/log/syslog.gz

then the output will be a list of those file names in the order shown
below, which should correspond to the order from oldest log messages
to newest log messages:

    /var/log/syslog.12.gz
    /var/log/syslog.11.gz
    /var/log/syslog.10.gz
    /var/log/syslog.9.gz
    /var/log/syslog.8.gz
    /var/log/syslog.7.gz
    /var/log/syslog.6.gz
    /var/log/syslog.5.gz
    /var/log/syslog.4.gz
    /var/log/syslog.3.gz
    /var/log/syslog.2.gz
    /var/log/syslog.1.gz
    /var/log/syslog.gz
""")
#parser.add_argument('-z', '--zgrep', dest='zgrep', action='store_true',
#                    help="""Run 'zgrep' command on the resulting list of
#                    sorted files.""")
args, remaining_args = parser.parse_known_args()

#print("dbg args=%s" % (args))
#print("dbg sys.argv=%s" % (sys.argv))
#print("dbg remaining_args=%s" % (remaining_args))
fnames = remaining_args
#print("dbg fnames=%s" % (fnames))

def contains_dot_number(s):
    match = re.match(r"^(.+)\.(\d+)(.*)$", s)
    if match:
        return {'before': match.group(1),
                'number_str': match.group(2),
                'after': match.group(3)}
    return None

fnames_with_firstboot = []
fnames_by_number = collections.defaultdict(list)
fnames_without_number = []
for fname in fnames:
    basename = os.path.basename(fname)
    if '.firstboot' in basename:
        fnames_with_firstboot.append(fname)
        continue
    m1 = contains_dot_number(basename)
    if m1 is None:
        fnames_without_number.append(fname)
        continue
    if contains_dot_number(m1['before']) or contains_dot_number(m1['after']):
        print("File name '%s' contains more than one decimal number in its"
              " basename.  Sorting it as if it had no number."
              "" % (fname),
              file=sys.stderr)
        fnames_without_number.append(fname)
        continue
    number_int = int(m1['number_str'])
    fnames_by_number[number_int].append(fname)

if len(fnames_with_firstboot) > 1:
    print("%d file names contain '.firstboot'."
          "  Leaving those files in same relative order as they"
          " appeared on the command line."
          "" % (len(fnames_with_firstboot)),
          file=sys.stderr)
for n in sorted(fnames_by_number.keys()):
    if len(fnames_by_number[n]) > 1:
        print("%d file names contain the same number %d."
              "  Leaving those files in same relative order as they"
              " appeared on the command line."
              "" % (len(fnames_by_number[n]), n),
              file=sys.stderr)

# Files with '.firstboot' come first.
#
# Then files with a single number in their names, in decreasing
# numeric order.
#
# Then files with no number in their names, nor '.firstboot'.

sorted_fnames = []
sorted_fnames += fnames_with_firstboot
for n in sorted(fnames_by_number.keys(), reverse=True):
    sorted_fnames += fnames_by_number[n]
sorted_fnames += fnames_without_number

print(' '.join(sorted_fnames))
