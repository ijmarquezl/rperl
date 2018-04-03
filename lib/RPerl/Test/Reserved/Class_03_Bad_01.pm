# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'P183b, CODE GENERATOR, ABSTRACT SYNTAX' >>>
# <<< GENERATE_ERROR: "subroutine argument name '_Foo_argument' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier" >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Reserved::Class_03_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnusedPrivateSubroutines)  # DEVELOPER DEFAULT 3: allow uncalled subroutines

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    foo_property => my string $TYPED_foo_property = 'quite a prize'
};


# [[[ SUBROUTINES & OO METHODS ]]]

sub _foo_subroutine {
    { my integer $RETURN_TYPE };
    ( my integer $Foo_argument_good, my integer $_Foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_03_Bad_01::_foo_subroutine(), received $_Foo_argument = ', $_Foo_argument, "\n";

    return ($_Foo_argument * 2);
}


sub _foo_method {
    { my integer::method $RETURN_TYPE };
    ( my RPerl::Test::Reserved::Class_03_Bad_01 $self, my integer $_Foo_argument ) = @ARG;

    print 'in RPerl::Test::Reserved::Class_03_Bad_01::_foo_method(), received $_Foo_argument = ', $_Foo_argument, "\n";
    print 'in RPerl::Test::Reserved::Class_03_Bad_01::_foo_method(), have $self->{foo_property} = ', q{'}, $self->{foo_property}, q{'}, "\n";

    return ($_Foo_argument * -2);
}

1;    # end of class
