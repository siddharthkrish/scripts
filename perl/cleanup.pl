#!/usr/bin/perl

use strict;
use warnings;
use File::Copy qw(move);

my $directory = '.';
opendir (DIR, $directory) or die $!;

while (my $file = readdir(DIR)) {
  if (!($file =~ m/^\./i)) {
    my $clean = $file;
    
    # name has to be of the format *SxxExx*
    if (-d $file) {
      $clean =~ s/.*([sS][0-9]+[eE][0-9]+).*(\..*$)*/$1/g;
    } else {
      $clean =~ s/.*([sS][0-9]+[eE][0-9]+).*(\..*$)/$1$2/g;
    }

    # rename filename if it has changed.
    if ("$file" ne "$clean") {
      move $file, $clean;
      print "$clean \n";
    }
  }
}

closedir(DIR);
exit 0;
