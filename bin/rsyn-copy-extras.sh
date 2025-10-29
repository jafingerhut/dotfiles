#! /bin/bash

# Combos that were supported before, with 6 nearly identical bash scripts:

# Extras -> Seagate4TB
# Extras -> MyBook4TB
# MyBook4TB -> Extras
# MyBook4TB -> Seagate4TB
# Seagate4TB -> Extras
# Seagate4TB -> MyBook4TB

#SRC_DISK="Extras"
#SRC_DISK="Seagate4TB"
#SRC_DISK="MyBook4TB"
#DST_DISK="Extras"
#DST_DISK="Seagate4TB"
#DST_DISK="MyBook4TB"

show_usage() {
    1>&2 echo "usage: `basename $0` <src_disk> <dst_disk> [ other-rsync-options ]"
    1>&2 echo ""
    1>&2 echo "Where <src_disk> and <dst_disk> can include names like these:"
    1>&2 echo ""
    1>&2 echo "    Extras"
    1>&2 echo "    Seagate4TB"
    1>&2 echo "    MyBook4TB"
    1>&2 echo "    SeagateBackup8TB"
    1>&2 echo ""
    1>&2 echo "Disks on-line in /Volumes now:"
    1>&2 echo ""
    1>&2 ls /Volumes
}

if [ $# -lt 2 ]
then
    show_usage
    exit 1
fi

SRC_DISK="$1"
shift
DST_DISK="$1"
shift

if [ ! -d /Volumes/${SRC_DISK} ]
then
    1>&2 echo "<src_disk>=${SRC_DISK} is not available now"
    1>&2 echo ""
    show_usage
    exit 1
fi

if [ ! -d /Volumes/${DST_DISK} ]
then
    1>&2 echo "<dst_disk>=${DST_DISK} is not available now"
    1>&2 echo ""
    show_usage
    exit 1
fi

#echo "debug rest of args: :$*:"
#exit 0

# rsync options, confirmed in rsync man page for rsync version 3.1.1,
# protocol version 31

#        -r, --recursive             recurse into directories
#        -l, --links                 copy symlinks as symlinks
#        -p, --perms                 preserve permissions
#        -t, --times                 preserve modification times
#        -g, --group                 preserve group
#        -v, --verbose               increase verbosity
#        -b, --backup                make backups (see --suffix & --backup-dir)
#        -u, --update                skip files that are newer on the receiver
#        -H, --hard-links            preserve hard links
#        -A, --acls                  preserve ACLs (implies -p)
#        -X, --xattrs                preserve extended attributes
#        -E, --executability         preserve executability
#        -N, --crtimes               preserve create times (newness)
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


RSYNC='rsync -rlptgvbuHAXEN --modify-window=5 --exclude .DS_Store'
# Get additional rsync options from command line of this script
RSYNC="$RSYNC $*"

$RSYNC /Volumes/${SRC_DISK}/ /Volumes/${DST_DISK}/ --exclude '.DocumentRevisions-V100' --exclude '.Spotlight-V100' --exclude '.TemporaryItems' --exclude '.Trashes' --exclude '.com.apple.timemachine.donotpresent' --exclude '.com.apple.timemachine.supported' --exclude '.fseventsd' --exclude 'disk-scan-info.txt' --exclude 'duplicates' --exclude 'backups' --exclude '.apdisk'
