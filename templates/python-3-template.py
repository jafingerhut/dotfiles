#! /usr/bin/env python

# If you don't know whether Python 3 is first in your cmd path
#### #!/router/bin/python-3.4.0
# If you do know Python 3 is first in your cmd path
#### `#! /bin/env python

import os, sys
import re
#import argparse
#import collections
#import fileinput
#import glob


# To enable logging in a standalone Python program (as opposed to one
# that is part of pyATS, which seems to configure the logger by
# default in its own specific way):

#import logging

# Can replace __name__ with any string you want to appear in the log
# messages.
#log = logging.getLogger(__name__)
#log.setLevel(logging.DEBUG)
#logging.basicConfig(stream=sys.stdout)


#    sys.exit(exit_status)

# Search for regex anywhere within string
#    match = re.search(r"re pattern here", string)
#    if match:

# Search for regex starting at beginning of string
#    match = re.match(r"re pattern here", string)
#    if match:

# For debugging
# import traceback
#    traceback.print_stack()  # to stderr
#    traceback.print_stack(file=sys.stdout)

# Cmd line args in sys.argv

# sys.argv[0] is command name
# sys.argv[1] is 1st arg after command name

# Find all files matching a shell glob pattern like "foo*.txt":
#import glob
#matching_filename_list = glob.glob("foo*.txt")

# Dictionaries with something similar to Perl's auto-vivification
#import collections
#dict_default0 = collections.defaultdict(int)
#dict_default0['a'] += 1   # Makes value for key 'a' equal to 1 even if key 'a' did not already have a value
#dict_default_emptylist = collections.defaultdict(list)
#dict_default_emptydict = collections.defaultdict(dict)

# This is a trickier example of a dict that auto-vivifies 2 levels of
# keys deep, and at that level the default value is 0.
#fancydict = collections.defaultdict(lambda : collections.defaultdict(int))
# This is a trickier example of a dict that auto-vivifies 3 levels of
# keys deep, and at that level the default value is 0.
#fancydict = collections.defaultdict(lambda : collections.defaultdict(lambda : collections.defaultdict(int)))

# Run a command '/path/to/res' with arg 'avail', and return its output as a
# string.
#import subprocess
#    output = subprocess.check_output(['/path/to/res', 'avail'])

######################################################################
# Parsing optional command line arguments
######################################################################

import argparse

parser = argparse.ArgumentParser(description="""
Text describing what this program does and how to use it.""")
parser.add_argument('--testbed', dest='testbed', type=topology.loader.load)
parser.add_argument('--R1', dest='R1', type=str,
                    help="""The name of the device in the testbed
                    file to test.""")
parser.add_argument('--module-num', dest='module_num', type=int,
                    help="""The slot number of the LC module that
                    is the focus of the performance test.  Routes
                    may be installed on other modules as well, but
                    this is the only one where various show
                    commands will be run to collect measurements.""")
parser.add_argument('--intfs', dest='intfs', nargs='+',
                    help="""One or more interfaces to bring up and
                    assign IP addresses to before adding routes.
                    This helps control which ASIC instances will
                    have routes installed in them.""")
parser.add_argument('--trace', dest='trace',
                    choices=['enable', 'disable', 'leave-unchanged'],
                    help="""If 'enable', then configure 'hardware
                    forwarding unicast trace'.  If 'disable', then
                    configure 'no hardware forwarding unicast
                    trace'.  If 'leave-unchanged' (the default if
                    this option is not specified), then do not
                    configure either command, but leave it as it
                    is on the device.""")
args = parser.parse_known_args()[0]


######################################################################
# Example of regex split across multiple lines, and using named
# instead of numbered fields.
######################################################################

    match = re.match(r"""(?x)
                        ^\s* (?P<size_bytes>\d+)
                         \s+ (?P<month>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)
                         \s+ (?P<day>\d+)
                         \s+ (?P<hour>\d+):(?P<minute>\d+):(?P<second>\d+)
                         \s+ (?P<year>\d+)
                         \s+ (?P<filename>.*)$""", line)
    if match:
        filename = match.group('filename')
        is_directory = False
        if filename[-1] == '/':
            is_directory = True
            filename = filename[:-1]
        file_info = {'is_directory': is_directory,
                     'size_bytes': match.group('size_bytes'),
                     'year': int(match.group('year')),
                     'month': match.group('month'),
                     'day': int(match.group('day')),
                     'hour': int(match.group('hour')),
                     'minute': int(match.group('minute')),
                     'second': int(match.group('second'))}


#for line in fileinput.input(files=['infile1', 'infile2']):

for line in fileinput.input():
    # do something to line here
    # Current file name: fileinput.filename()
    # Line number within current file: fileinput.filelineno()
    # Cumulative line number across all files: fileinput.lineno()
    match = re.search(r"re pattern here", line)
    if match:
