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

my Str @flines = 'aoc_input02.txt'.IO.lines;
my $rgx = rx/ (< forward down up>) \s* (\d+) /;

#`{{
    forward X increases the horizontal position by X units.
    down X increases the depth by X units.
    up X decreases the depth by X units.
}}
{
  my (Int $hPos, Int $dPos) = 0,0;
  for @flines -> $lns {
    my $cm = $lns.match($rgx);
    given ~$cm[0] {
      when 'forward' {$hPos += +$cm[1]}
      when 'down' {$dPos += +$cm[1]}
      when 'up' {$dPos -= +$cm[1]}
    }
  }
  say "h $hPos d $dPos m {$hPos * $dPos}";
}

#`{{
    down X increases your aim by X units.
    up X decreases your aim by X units.
    forward X does two things:
        It increases your horizontal position by X units.
        It increases your depth by your aim multiplied by X
}}
{
  my (Int $hPos, Int $dPos, Int $aim) = 0,0,0;
  for @flines -> $lns {
    my $cm = $lns.match($rgx);
    given ~$cm[0] {
      when 'forward' {$hPos += +$cm[1]; $dPos += ($aim * +$cm[1]);}
      when 'down' {$aim += +$cm[1]}
      when 'up' {$aim -= +$cm[1]}
    }
  }
  say "h $hPos d $dPos m {$hPos * $dPos}";
}

