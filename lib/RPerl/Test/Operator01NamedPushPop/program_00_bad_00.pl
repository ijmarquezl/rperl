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
my integer $frob_length = push @{$frob}, 21, 12, 23; # Operator, yes parentheses required for builtin w/ multiple arguments in non-void context
print 'have $frob_length = ', $frob_length, "\n";
print 'have $frob = ', "\n", Dumper($frob), "\n";

my integer $frob_pop = pop @{$frob};
print 'have $frob_pop = ', "\n", $frob_pop, "\n";
print 'have $frob = ', "\n", Dumper($frob), "\n";