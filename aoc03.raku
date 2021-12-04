#!/usr/bin/env raku
# https://adventofcode.com/2021
# day 02 - submarine takes commands
# multiply your final horizontal position by your final depth

# © 2021 Stephen J Pollei
# License: GNU Library General Public License, version 2.0 (LGPL-2.0-or-later)
#          https://www.gnu.org/licenses/old-licenses/lgpl-2.0.html
# License: Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
#          https://creativecommons.org/licenses/by-nc-nd/4.0/
# License-Identifier: LGPL-2.0-or-later OR CC-BY-ND-4.0 # SPDX

use v6;
my Int constant $year = 2021;

sub trns(Str $x) returns List { return +<<$x.split('', :skip-empty);}
sub sumCmp(Numeric $x, Numeric $y) returns Bool {return $x >= $y;}
sub mkBin($x, $y) returns Int { return 2*$x + $y; }

sub fndRating(@bns, $cond=True, $indx=0 ) returns Int {
  my $sum=0;
  for @bns -> $n {$sum++ if $n[$indx];}
  my Bool $f = ($sum >= @bns.elems/2) ?^ $cond;
  my @ssBns = @bns.grep( {$_[$indx] ?^ $f} );
  return @ssBns[0].reduce( &mkBin) if @ssBns.elems == 1;
  return fndRating(@ssBns,$cond, $indx+1);
}

my @flines = 'aoc_input03.txt'.IO.lines>>.&trns ;

my @sums = [>>+<<] @flines;
my @cmps = @sums[0].map( &sumCmp.assuming( *, @flines.elems/2) );

say @cmps.reduce( &mkBin) ~ " " ~ (!<<@cmps).reduce( &mkBin);
say (@cmps.reduce( &mkBin))*((!<<@cmps).reduce( &mkBin));

my Int $oxRate= fndRating(@flines);
my Int $co2Rate= fndRating(@flines,False);
say "ox $oxRate co2 $co2Rate life {$oxRate*$co2Rate}";

