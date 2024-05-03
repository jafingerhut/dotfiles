#! /bin/bash

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

######################################################################
# Sort a log file consisting of one log message per line, by date and
# time.
#
# Assumption: You have a log file where the first 3 "fields" (strings
# without whitespace in them, separated from other fields by
# whitespace), are:
#
# (1) An abbreviated month name
# (2) The number of the day in the month
# (3) A time in a format that can be sorted alphabetically,
#     e.g. HH:MM:SS.XXXXX as shown in the example log line below.
#
# Example log line:
# Jan 25 15:50:10.260600 log message goes here, and never affects the sort order
######################################################################

# Most significant sort field is 1, the month abbreviation, sorted
# month-wise (-M)

# If field 1 is equal for two lines, the next most significant sort
# field is 2, the day of the month, sorted numerically (-n), since it
# does not have leading zeroes for single-digit days.

# If both fields 1 and 2 are equal for two lines, the next most
# significant sort field is 3.  Field 3 is a time in the format
# HH:MM:SS.XXXXXX, with leading zeroes, so normal 'sort' sort order is
# OK.

# It can be done with multiple invocations of sort in a pipeline:
#sort -s -k 3,3 | sort -s -n -k 2,2 | sort -s -M -k 1,1

# But this single invocation of sort also works:
sort -s -k 1,1M -k 2,2n -k 3,3
