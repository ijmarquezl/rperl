#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword found where operator expected' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my number $foo  = 9_123.456_789;
my string $bar  = 'howdy';
my integer $bat = $foo == 22;
my integer $baz = 9_123.456_789 == $foo;
my integer $bax = 33 != 44;

print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = $foo == 333_333_333_333;
$baz = 444 != 222;
$bax = 33 != $foo;

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = $foo <=> 333_333_333_333;
$baz = 444 <=> 222;
$bax = 33 <=> $foo;

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = $bar neq 'howdy';
$baz = 'ZZZZZZZZZZZZZZ' eq $bar;
$bax = '33' ne '44';

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = $bar eq 'abc';
$baz = '444' ne '222';
$bax = '33' ne $bar;

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";

$bat = $bar cmp 'abc';
$baz = '444' cmp '222';
$bax = '33' cmp $bar;

print 'have $bat = ', $bat, "\n";
print 'have $baz = ', $baz, "\n";
print 'have $bax = ', $bax, "\n";
