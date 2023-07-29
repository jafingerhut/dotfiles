#! /usr/bin/env python3

import ast
import fileinput
import json
import re
import sys

# Convert the output of periodic-disk-usage.py into a CSV file that
# can easily be read into a spreadsheet program for further analysis.

# First read in all the data, so we can check afterwards whether we
# have a consistent set of filesystems reported on across all samples,
# before generating CSV.

samples = []
for line in fileinput.input():
    disk_usage_data = ast.literal_eval(line)
    if type(disk_usage_data) is not dict:
        print("Line %d is not a dict: %s"
              "" % (fileinput.lineno(), line))
    #print()
    #print('just_before=%.2f' % (disk_usage_data['just_before_time']))
    #print('just_after=%.2f' % (disk_usage_data['just_after_time']))
    if 'input_line' in disk_usage_data:
        print("Did not expect key 'line' in this input line: %s" % (line))
        sys.exit(1)
    disk_usage_data['input_line'] = {'line_text': line,
                                     'linenum': fileinput.lineno()}
    samples.append(disk_usage_data)

print("Read %d lines" % (len(samples)), file=sys.stderr)

def error_if_key_missing(d, key_str, loc_info):
    if key_str not in d:
        print("Dict on line %d is missing expected key %s: %s"
              "" % (loc_info['linenum'],
                    key_str,
                    loc_info['line_text']),
              file=sys.stderr)
        sys.exit(1)

def extract_disk_usage_as_int(s, loc_info):
    s = s.strip()
    match = re.match(r"""^(\d+)M$""", s)
    if match:
        return int(match.group(1))
    print("Found string '%d' expected to be a disk usage in the format '<integer>M' on line %d"
          "" % (s, loc_info['linenum']),
          file=sys.stderr)
    sys.exit(1)

all_filesystems = {}
out_data = []
for s in samples:
    loc_info = s['input_line']
    error_if_key_missing(s, 'just_before_time', loc_info)
    error_if_key_missing(s, 'just_after_time', loc_info)
    error_if_key_missing(s, 'disk_usage', loc_info)
    dat = s['disk_usage']
    filesystems = {}
    num_filesystems = 0
    for e in dat:
        num_filesystems += 1
        error_if_key_missing(e, 'file_system', loc_info)
        error_if_key_missing(e, 'total', loc_info)
        error_if_key_missing(e, 'used', loc_info)
        error_if_key_missing(e, 'available', loc_info)
        error_if_key_missing(e, 'mounted', loc_info)

        unique_name = e['mounted']
        
        if unique_name in filesystems:
            print("Line %d contains more then one record about filesystem '%s': %s"
                  "" % (loc_info['linenum'],
                        unique_name,
                        loc_info['line_text']))
            sys.exit(1)
        all_filesystems[unique_name] = True
        filesystems[unique_name] = \
            {'used': extract_disk_usage_as_int(e['used'], loc_info),
             'available': extract_disk_usage_as_int(e['available'], loc_info)}
#    print("dbg found %d filesystems on line %d"
#          "" % (num_filesystems, loc_info['linenum']))
    tmp = {'disk_usage': filesystems,
           'just_before_time': s['just_before_time'],
           'just_after_time': s['just_after_time'],
           'input_line': loc_info}
    out_data.append(tmp)

file_system_print_seq = sorted(all_filesystems.keys())
print("Found %d total file systems, to be printed in this order:"
      "" % (len(file_system_print_seq)),
      file=sys.stderr)
for f in file_system_print_seq:
    print("    %s" % (f), file=sys.stderr)

# Print CSV header line
header_line = '"sample","just_before_time","just_after_time"'
for f in file_system_print_seq:
    header_line += (',"%s used"' % (f))
    header_line += (',"%s avail"' % (f))
print(header_line)
n = 0
for x in out_data:
    n += 1
    line = "%s" % (n)
    line += (',%s' % (x['just_before_time']))
    line += (',%s' % (x['just_after_time']))
    for f in file_system_print_seq:
        if f in x['disk_usage']:
            line += (',%d,%d' % (x['disk_usage'][f]['used'],
                                 x['disk_usage'][f]['available']))
        else:
            line += ',"",""'
    print(line)
