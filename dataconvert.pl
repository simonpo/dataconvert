#!/usr/bin/env perl
# use strict;
# use warnings;

open(FILE, "<", "hawkgigs.csv") || die("Can't open file: $!");

my %data; 

while(<FILE>){
    my @line = split(/\t/,$_);
    my $key = $line[6] . '-' .$line[5];
    my $value = "$line[3] $line[4] \($line[7]\)";
    $value =~ s/ +/ /g;
    $value =~ s/\t//g;
    push @{ $data{$key} }, $value;
}

for my $key (sort keys %data) {
    my $outfile = $key . ".txt";
    open(OUTFILE, ">./output/$outfile") || die "Cannot open file: $!";
    my %monthName; 
    @monthName{ 1 .. 12 } = qw(Jan Feb Mar Apr May Jun Jul Aug Sept Oct Nov Dec);
    my ($month,$day) = split('-',$key);
    printf OUTFILE "On %s. %s, #Hawkwind played %s\n", $monthName{$month}, $day, join ', ', @{ $data{$key} };
    close(OUTFILE);
}
