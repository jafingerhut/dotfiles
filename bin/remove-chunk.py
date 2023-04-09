#! /usr/bin/env python3

import os, sys
import re
import argparse
import fileinput

######################################################################
# Parsing optional command line arguments
######################################################################

parser = argparse.ArgumentParser(description="""

Read the contents of a text file <chunkfile>, then read and search the
contents of <inputfile> to see if it contains a consecutive sequence
of lines that are the same as the sequence of lines in <chunkfile>.

If no, copy <inputfile> to <outputfile>.

If yes, copy <inputfile> to <outputfile>, except omit the first
consecutive sequence of lines in <inputfile> that are the same as
<chunkfile>.
""")
parser.add_argument('-i', '--input', dest='input', type=str, required=True,
                    help="""The file name for <inputfile>.""")
parser.add_argument('-c', '--chunk', dest='chunk', type=str, required=True,
                    help="""The file name for <chunkfile>.""")
parser.add_argument('-o', '--output', dest='output', type=str, required=True,
                    help="""The file name for <outputfile>.""")
parser.add_argument('-w', '--ignore-all-space', dest='ignore_all_space',
                    action='store_true',
                    help="""Ignore all white space when comparing
                    contents of lines in chunk file against lines
                    of input file.""")
parser.add_argument('-Z', '--ignore-trailing-space', dest='ignore_trailing_space',
                    action='store_true',
                    help="""Ignore white space at line end when comparing
                    contents of lines in chunk file against lines
                    of input file.""")
parser.add_argument('-A', '--ignore-leading-space', dest='ignore_leading_space',
                    action='store_true',
                    help="""Ignore white space at line beginning when comparing
                    contents of lines in chunk file against lines
                    of input file.""")

args = parser.parse_known_args()[0]

#print('args.input=%s' % (args.input))
#print('args.chunk=%s' % (args.chunk))
#print('args.output=%s' % (args.output))
#print('args.ignore_all_space=%s (%s)' % (args.ignore_all_space, type(args.ignore_all_space)))

def adjust_line(s, args):
    if args.ignore_all_space:
        return "".join(s.split())
    if args.ignore_trailing_space:
        s = s.rstrip()
    if args.ignore_leading_space:
        s = s.lstrip()
    return s

chunk_lines = []
for line in fileinput.input(files=[args.chunk]):
    line_to_compare = adjust_line(line, args)
    chunk_lines.append(line_to_compare)

num_chunk_lines = len(chunk_lines)

# TODO: We could use Boyer-Moore style string matching algorithm,
# where the "characters" are complete lines, but the chunkfile inputs
# I expect to use as inputs are quite short, and would get little or
# no efficiency improvement from that.

# Make the code simpler to implement by assuming small enough input
# file that it is reasonable to read it all into memory before
# printing any output.  There are definitely straightforward ways to
# do this that keep at most num_chunk_lines of the input file in
# memory at once, but I won't bother to do that now, again, because I
# expect to use this on fairly small files.

input_lines = []
input_lines_to_compare = []
for line in fileinput.input(files=[args.input]):
    input_lines.append(line)
    line_to_compare = adjust_line(line, args)
    input_lines_to_compare.append(line_to_compare)

def chunk_matches_starting_at_idx(start_idx, input_lines, chunk_lines, args):
    if (start_idx + len(chunk_lines)) > len(input_lines):
        return False
    for offset in range(len(chunk_lines)):
        if chunk_lines[offset] != input_lines[start_idx + offset]:
            return False
    return True

match_start_idx = None
for start_idx in range(len(input_lines)):
    if chunk_matches_starting_at_idx(start_idx, input_lines, chunk_lines, args):
        match_start_idx = start_idx
        break
    
remove_lines = False
if match_start_idx is None:
    remove_lines = False
else:
    remove_lines = True
    min_idx_to_remove = match_start_idx
    max_idx_to_remove = match_start_idx + len(chunk_lines) - 1
    
with open(args.output, 'w') as outputf:
    for idx in range(len(input_lines)):
        if remove_lines and (min_idx_to_remove <= idx) and (idx <= max_idx_to_remove):
            pass
        else:
            print(input_lines[idx], end='', file=outputf)
