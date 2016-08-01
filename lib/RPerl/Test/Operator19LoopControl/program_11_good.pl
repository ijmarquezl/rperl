#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $i = 2' >>>
# <<< EXECUTE_SUCCESS: 'have $i = 4' >>>
# <<< EXECUTE_SUCCESS: 'have $i = 6' >>>
# <<< EXECUTE_SUCCESS: 'have $i = 8' >>>
# <<< EXECUTE_SUCCESS: 'have $i = 10' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $i = 0;
while ($i < 10) {
    $i++;
    if ($i % 2) { next; }
    print 'have $i = ', $i, "\n";
}