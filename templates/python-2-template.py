#!/router/bin/python-2.7.4

from __future__ import print_function
import os, sys
import re
#import argparse
#import collections
#import fileinput
#import glob

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

# Iterate over all key/value pairs in a dict, in arbitrary order:
# for k, v in mydict.items():

# Iterate over all keys in a dict, in sorted order:
# for k in sorted(mydict.keys()):

# Iterate over a list/whatever, maintaining an index variable
# automatically:
#
# "Works in many imperative programming languages:"
#    index = 0 # python indexing starts at zero
#    for item in items:
#        print(index, item)
#        index += 1
#
# "Pythonic way:"
# for index, item in enumerate(items, start=0):   # default is zero
#     print(index, item)
#
# Source, with other suggestions, too:
# http://stackoverflow.com/questions/522563/accessing-the-index-in-python-for-loops

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

for line in fileinput.input():
    # do something to line here
    # Current file name: fileinput.filename()
    # Line number within current file: fileinput.filelineno()
    # Cumulative line number across all files: fileinput.lineno()
    match = re.search(r"re pattern here", line)
    if match:
