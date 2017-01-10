#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  ,' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my integer_arrayref $frob = [];
my integer $frob_length = unshift @{$frob}, 21, 12, 23;
print 'have $frob_length = ', $frob_length, "\n";
print 'have $frob = ', "\n", Dumper($frob), "\n";

my integer $frob_shift = shift @{$frob};
print 'have $frob_shift = ', "\n", $frob_shift, "\n";
print 'have $frob = ', "\n", Dumper($frob), "\n";