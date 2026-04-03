#! /bin/bash

#echo "debug rest of args: :$*:"
#exit 0

# rsync options, confirmed in rsync man page for rsync version 3.4.1,
# protocol version 32

#        -r, --recursive             recurse into directories
#        -l, --links                 copy symlinks as symlinks
#        -p, --perms                 preserve permissions
#        -t, --times                 preserve modification times
#        -g, --group                 preserve group
#        -v, --verbose               increase verbosity
#        -b, --backup                make backups (see --suffix & --backup-dir)
#        -u, --update                skip files that are newer on the receiver
#        -H, --hard-links            preserve hard links
#        -E, --extended-attributes
#             Apple specific option to copy extended attributes, resource forks, and ACLs.
#             Requires at least Mac OS X 10.4 or suitably patched rsync.
#        --executability
#            --modify-window=NUM     compare mod-times with reduced accuracy
#            --exclude=PATTERN       exclude files matching PATTERN

# rsync options not used:

#            --exclude-from=FILE     read exclude patterns from FILE
#        -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
#        -o, --owner                 preserve owner (super-user only)
#            --devices               preserve device files (super-user only)
#            --specials              preserve special files
#        -D                          same as --devices --specials
#        -n, --dry-run               perform a trial run with no changes made
#        -W, --whole-file            copy files whole (w/o delta-xfer algorithm)
#        -x, --one-file-system       don't cross filesystem boundaries
#        -B, --block-size=SIZE       force a fixed checksum block-size
#        -m, --prune-empty-dirs      prune empty directory chains from file-list
#        -I, --ignore-times          don't skip files that match size and time
#        -T, --temp-dir=DIR          create temporary files in directory DIR
#        -y, --fuzzy                 find similar file for basis if no dest file
#        -z, --compress              compress file data during the transfer
#        -C, --cvs-exclude           auto-ignore files in the same way CVS does
#        -f, --filter=RULE           add a file-filtering RULE
#        -F                          same as --filter='dir-merge /.rsync-filter'
#        -0, --from0                 all *from/filter files are delimited by 0s
#        -s, --protect-args          no space-splitting; wildcard chars only
#        -8, --8-bit-output          leave high-bit chars unescaped in output
#        -h, --human-readable        output numbers in a human-readable format
#        -i, --itemize-changes       output a change-summary for all updates
#        -M, --remote-option=OPTION  send OPTION to the remote side only
#        -4, --ipv4                  prefer IPv4
#        -6, --ipv6                  prefer IPv6


RSYNC='rsync -rlptgvbuHE --executability --modify-window=5 --exclude .DS_Store'
# Get additional rsync options from command line of this script
RSYNC="$RSYNC $*"

$RSYNC --exclude '.DocumentRevisions-V100' --exclude '.Spotlight-V100' --exclude '.TemporaryItems' --exclude '.Trashes' --exclude '.com.apple.timemachine.donotpresent' --exclude '.com.apple.timemachine.supported' --exclude '.fseventsd' --exclude 'disk-scan-info.txt' --exclude 'duplicates' --exclude 'backups' --exclude '.apdisk'
