: # use perl -*-Perl-*-
eval 'exec perl -S "$0" ${1+"$@"}'
    if 0;
# -*cperl-*-

use strict;
use Getopt::Long;
use File::Basename;
# File::Temp is a library for creating temporary files.
use File::Temp;
# FindBin is a library to find the directory in which the script is
# installed.  This can be useful for making it easy to install other
# auxiliary files needed by the script all in one place, and no matter
# where someone installs 'the whole package' of files, the script can
# find them, without needing hand-editing.
use FindBin;
# Below is an example use of the $FindBin::Bin string variable defined
# by the line above, to include the 'build' subdirectory beneath that
# in the list of directories searched when finding .pm files for later
# 'use' statements.  Useful if a .pm file is part of 'the whole
# package' you want to distribute with this script.
use lib "$FindBin::Bin" . "/build";


#my $debug = 1;

my $verbose = 0;
my $full_progname = $0;
my $progname = fileparse($full_progname);

sub usage {
    print STDERR
"usage: $progname [ --help ] [ --verbose ]
               [ file1 ... ]

description here
";
}

my $help = 0;
if (!GetOptions('help' => \$help,
		'verbose+' => \$verbose
		))
{
    usage();
    exit 1;
}
if ($help) {
    usage();
    exit 0;
}

my $nargs = 1 + $#ARGV;
printf "\$nargs = %d\n", $nargs;
my $i;
for ($i = 0; $i <= $#ARGV; $i++) {
    printf "%2d :%s:\n", $i, $ARGV[$i];
}

printf "\n";
printf "\@INC:\n";
$i = 0;
for (@INC) {
    printf "%2d :%s:\n", $i, $_;
    $i++;
}

exit 0;
