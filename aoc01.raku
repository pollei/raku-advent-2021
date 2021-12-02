#!/usr/bin/env raku
# https://adventofcode.com/2021
# day 01 - count the number of times a depth measurement increases
# also compare sums of a three-measurement sliding window

# © 2021 Stephen J Pollei
# License: GNU Library General Public License, version 2.0 (LGPL-2.0-or-later)
#          https://www.gnu.org/licenses/old-licenses/lgpl-2.0.html
# License: Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
#          https://creativecommons.org/licenses/by-nc-nd/4.0/
# License-Identifier: LGPL-2.0-or-later OR CC-BY-ND-4.0 # SPDX

use v6;
constant $year = 2021;

sub cntIncs(Int @vals, Int $by=1) returns Int {
  fail "too small" if @vals.elems < $by;
  return [+] @vals[$by .. *] Z> @vals;
}

my IO::Handle $file = open 'aoc_input01.txt';

my Int @vals = gather for $file.lines -> $line {take Int($line)};

# say 0,1, * + * ...  * > 2**31;

my Int %cnts{Int} =
  1 => cntIncs(@vals  ),
  3 => cntIncs(@vals,3);

say "total single count is {%cnts{1}}";
say "total triple count is {%cnts{3}}";


