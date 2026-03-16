#! /usr/bin/env python3

# Example command line:

# internet-checksum.py --data 450000343039400040110000C0A80101C0A801C7


import re
import struct
import sys

######################################################################
# Parsing optional command line arguments
######################################################################

import argparse

parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description="""
Calculate Internet checksum on a sequence of bytes specified on command line.
""")
parser.add_argument('--data', dest='data', type=str, required=True,
                    help=""" Sequence of bytes over which to calculate the Internet
                    checksum. It must be specified in hexadecimal
                    ASCII digits, optionally preceded with 0x or 0X,
                    with an even number of bytes.""")

args, remaining_args = parser.parse_known_args()

def print_data_format_usage():
    print("--data must be a sequence of hexadecimal digits, optionally preceded with 0x or 0X, that contains an even number of bytes.", file=sys.stderr)

data_str = args.data
if data_str[0:2] == '0x' or data_str[0:2] == '0X':
    data = data[2:]

if not re.match(r"""[0-9a-fA-F]+""", data_str):
    print_data_format_usage()
    sys.exit(1)

if len(data_str) % 4 != 0:
    print_data_format_usage()
    sys.exit(1)

data_bytes = bytes()
while len(data_str) > 0:
    byte_val = int(data_str[0:2], 16)
    data_bytes += bytes([byte_val])
    data_str = data_str[2:]


def calculate_ipv4_checksum(ip_header_bytes):
    """
    Calculates the IPv4 header checksum.

    Args:
        ip_header_bytes (bytes): The IPv4 header as a bytes object.
                                 The checksum field should be set to 0x0000
                                 before passing to this function.

    Returns:
        int: The calculated 16-bit IPv4 header checksum.
    """
    s = 0
    # Iterate through the header 16 bits at a time
    for i in range(0, len(ip_header_bytes), 2):
        # Unpack two bytes as an unsigned short (16-bit word) in network byte order (big-endian)
        w = struct.unpack('!H', ip_header_bytes[i:i+2])[0]
        s = s + w

    # Handle carries (wrap around)
    while (s >> 16) > 0:
        s = (s & 0xFFFF) + (s >> 16)

    # Take the one's complement
    checksum = ~s & 0xFFFF
    return checksum

# Example usage:
# A sample IPv4 header (20 bytes) with checksum field set to 0x0000
# (Version, IHL, TOS, Total Length, ID, Flags, Frag Offset, TTL, Protocol,
# Source IP, Destination IP)
# Note: The checksum field is at bytes 10 and 11 (0-indexed)
# This example header corresponds to:
# Version=4, IHL=5 (20 bytes), TOS=0, Total Length=52, ID=12345,
# Flags=DF (0x40), Frag Offset=0, TTL=64, Protocol=17 (UDP),
# Source IP=192.168.1.1, Destination IP=192.168.1.199
#ip_header_example = bytes([
#    0x45, 0x00, 0x00, 0x34,  # Version/IHL, TOS, Total Length
#    0x30, 0x39, 0x40, 0x00,  # Identification, Flags/Fragment Offset
#    0x40, 0x11, 0x00, 0x00,  # TTL, Protocol, Checksum (initially 0)
#    0xC0, 0xA8, 0x01, 0x01,  # Source IP
#    0xC0, 0xA8, 0x01, 0xC7   # Destination IP
#])

#calculated_checksum = calculate_ipv4_checksum(ip_header_example)
#print(f"Calculated IPv4 Checksum: 0x{calculated_checksum:04x}")

calculated_checksum = calculate_ipv4_checksum(data_bytes)
print(f"Calculated IPv4 Checksum: 0x{calculated_checksum:04x}")
