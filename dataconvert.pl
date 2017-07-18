#!/usr/bin/env perl
# use strict;
# use warnings;

open(FILE, "<", "hawkgigs.txt") || die("Can't open file: $!");

my %data; 

while(<FILE>){
    my @line = split(/\t/,$_);
    my $key = $line[6] . '-' .$line[5];
    # previously, I used (year in brackets), but that wastes valuable Tweet characters so let's use last two chars of year instead
    my $shortYear = substr $line[7], 2, 2;
    my $value = "$line[3] $line[4] \'$shortYear";
    # take out the London's and extra spaces, we don't need them
    $value =~ s/London //;
    $value =~ s/\s+/ /g;
    push @{ $data{$key} }, $value;
}

for my $key (sort keys %data) {
    my $outfile = $key . ".txt";
    open(OUTFILE, ">./output/$outfile") || die "Cannot open file: $!";
    my %monthName; 
    @monthName{ 1 .. 12 } = qw(Jan Feb Mar Apr May June July Aug Sept Oct Nov Dec);
    my ($month,$day) = split('-',$key);
    printf OUTFILE "On %s %s, #Hawkwind played %s\n", $monthName{$month}, $day, join ', ', @{ $data{$key} };
    close(OUTFILE);

    # log to screen
    print "Wrote $outfile\t : ";
    open(FILE, "<./output/$outfile") || die "Could not open file: $!\n";
    my $chars = 0;
    while (<FILE>) {
        $chars += length($_);
    }
    print "$chars\n";
}
