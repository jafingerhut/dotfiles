#! /usr/bin/env python3

import os, sys, re, fileinput, copy

# I have seen /var/lib/dpkg/status files containing descriptions of
# multiple packages installed with the same package name, with
# different architectures.  Make pkgs a list, not a map indexed by
# package name, otherwise we will not report information about all
# installed packages.
pkgs = []
pkg = {}

print(len(sys.argv))
if len(sys.argv) != 1 and len(sys.argv) != 2:
    print("usage: %s [ <dpkg-status-filename-to-read> ]"
          "" % (sys.argv[0]), file=sys.stderr)
    sys.exit(1)

dpkg_status_fname = '/var/lib/dpkg/status'
if len(sys.argv) == 2:
    dpkg_status_fname = sys.argv[1]

for line in fileinput.input(dpkg_status_fname):
    line = line.rstrip()
    # Blank lines separate info about different packages
    if line == '':
        if 'installed_size' not in pkg:
            pkg['installed_size'] = 0
        if ('name' not in pkg):
            print('problem with pkg=%s' % (pkg))
        assert pkg['name'] is not None and pkg['installed_size'] is not None
        pkgs.append(pkg)
        pkg = {}
        continue
    match = re.search(r"^Package:\s*(.*)$", line)
    if match:
        pkg['name'] = match.group(1)
        continue
    match = re.search(r"^Installed-Size:\s*(.*)$", line)
    if match:
        size_str = match.group(1)
        match = re.search(r"^\d+$", size_str)
        if not match:
            print("Found line '%s' with value that wasn't a decimal integer"
                  "" % (line))
            sys.exit(1)
        pkg['installed_size'] = int(size_str)
        continue

# Put the last pkg in pkgs, if there was no blank line at the end of the file
if (len(pkg) > 0 and pkg['name'] is not None and
    pkg['installed_size'] is not None):
    pkgs.append(pkg)

total_size = 0
for pkg in pkgs:
    total_size += pkg['installed_size']

pkgs_by_size = sorted(pkgs,
                      key=lambda pkg: (pkg['installed_size'], pkg['name']))

for pkg in pkgs_by_size:
    print("%d %s" % (pkg['installed_size'], pkg['name']))

size_so_far = 0
n = 0
n_pkgs_50_pct = None
n_pkgs_90_pct = None
pkgs_by_size_rev = copy.deepcopy(pkgs_by_size)
pkgs_by_size_rev.reverse()
for pkg in pkgs_by_size_rev:
    size_so_far += pkg['installed_size']
    n += 1
    if n_pkgs_50_pct is None and size_so_far >= (0.5 * total_size):
        n_pkgs_50_pct = n
        pct_50_pct = (100.0 * size_so_far) / total_size
    if n_pkgs_90_pct is None and size_so_far >= (0.9 * total_size):
        n_pkgs_90_pct = n
        pct_90_pct = (100.0 * size_so_far) / total_size

print()

# Printing number with commas for thousands separators:
#https://stackoverflow.com/questions/1823058/how-to-print-number-with-commas-as-thousands-separators

# More comprehensive info on Python format here: https://pyformat.info

print("{0} packages with total size {1} ({1:,})".format(
    len(pkgs), total_size))
print("{0} largest packages account for {1:.1f}% of total size".format(
    n_pkgs_50_pct, pct_50_pct))
print("{0} largest packages account for {1:.1f}% of total size".format(
    n_pkgs_90_pct, pct_90_pct))
