#! /usr/bin/env python3

import os, sys, re, fileinput, copy

pkgs = {}
pkg = {}

for line in fileinput.input('/var/lib/dpkg/status'):
    line = line.rstrip()
    # Blank lines separate info about different packages
    if line == '':
        assert pkg['name'] is not None and pkg['installed_size'] is not None
        pkgs[pkg['name']] = pkg
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
    pkgs[pkg['name']] = pkg

total_size = 0
for pkg_name in pkgs:
    pkg = pkgs[pkg_name]
    total_size += pkg['installed_size']

pkg_lst = [pkgs[pkg_name] for pkg_name in pkgs]
pkgs_by_size = sorted(pkg_lst,
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
