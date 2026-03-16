#! /usr/bin/env python3

import argparse
import collections
import os, sys
import fileinput

parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description="""
Concatenate input files to the stdout, truncating lines
that are longer than a specified (or default) maximum number
of characters.
""")
parser.add_argument('--show-stats', dest='show_stats',
                    action='store_true',
                    help="""
                    When this option is given, only statistics of
                    how many lines have which number of characters
                    will be printed to stdout.""")
parser.add_argument('--max-chars', dest='max_chars', type=int,
                    default=512,
                    help="""The mximum number of characters of
                    an input line that is not truncated, and the
                    number of characters printed of lines that are
                    longer than that.""")
args, remaining_args = parser.parse_known_args()

#print("args.show_stats=%s" % (args.show_stats))
#print("args.max_chars=%s" % (args.max_chars))
#print("remaining_args=%s" % (remaining_args))
#sys.exit(0)

line_lengths = collections.defaultdict(int)

for line in fileinput.input(files=remaining_args):
    line = line.rstrip()
    n = len(line)
    line_lengths[n] += 1
    if not args.show_stats:
        if n > args.max_chars:
            line = line[:args.max_chars] + ' (truncated from original length of %d chars)' % (n)
        print(line)

if args.show_stats:
    print("# lines   # of characters on line")
    print("--------- -----------------------")
    for n in sorted(line_lengths.keys()):
        print("%9d %d" % (line_lengths[n], n))
