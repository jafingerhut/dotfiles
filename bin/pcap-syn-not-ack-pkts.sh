#! /bin/bash

# -t don't print timestamps
# -n don't convert IP addresses or port numbers to names

# Show packets with SYN 1, FIN 1, or RST 1
#tcpdump -t -n -r pkts.pcap 'tcp[tcpflags] & (tcp-syn|tcp-fin|tcp-rst) != 0' > pkts.txt

# Show only packets that have SYN 1 and ACK 0
tcpdump -t -n 'tcp[tcpflags] & (tcp-syn) != 0 and tcp[tcpflags] & (tcp-ack) == 0' $*
