#!/usr/bin/perl

use Data::Dumper;
use rperlgsl;  # give us Math::GSL::Matrix

# does not seem to be necessary to trigger -D__CPP__TYPES
#use rperltypes;
#rperltypes::types_enable('CPP');

use RPerl::DataStructure::GSLMatrix qw(gsl_matrix__typetest0 gsl_matrix__typetest1 gsl_matrix__typetest99);

use RPerl::DataStructure::GSLMatrix_cpp;
RPerl::DataStructure::GSLMatrix_cpp::cpp_load();





print "#=" x 30, "\n";
print "#=" x 30, "\n";
print "\n\n";

print 'have main::RPerl__DataStructure__GSLMatrix__MODE_ID() = ', main::RPerl__DataStructure__GSLMatrix__MODE_ID(), "\n";
print 'have main::gsl_matrix__typetest99() = ', main::gsl_matrix__typetest99(), "\n";

my gsl_matrix $m_typetest0 = gsl_matrix__typetest0();
print 'have $m_typetest0 = ', Dumper($m_typetest0);
print 'have gsl_matrix_get($m_typetest0, 0, 0) = ', gsl_matrix_get($m_typetest0, 0, 0), "\n";
print "\n\n";

my gsl_matrix $m_typetest1 = gsl_matrix_alloc(2, 2);
gsl_matrix_set($m_typetest1, 0, 0, 10);
gsl_matrix_set($m_typetest1, 0, 1, 15);
gsl_matrix_set($m_typetest1, 1, 0, 20);
gsl_matrix_set($m_typetest1, 1, 1, 25);
print 'have pre-call gsl_matrix_get($m_typetest1, 0, 0) = ', gsl_matrix_get($m_typetest1, 0, 0), "\n";
print 'have pre-call gsl_matrix_to_string($m_typetest1) = ', "\n", gsl_matrix_to_string($m_typetest1), "\n";
$m_typetest1 = gsl_matrix__typetest1($m_typetest1);
print 'have post-call gsl_matrix_get($m_typetest1, 0, 0) = ', gsl_matrix_get($m_typetest1, 0, 0), "\n";
print 'have post-call gsl_matrix_to_string($m_typetest1) = ', "\n", gsl_matrix_to_string($m_typetest1), "\n";


print "\n\n";
print "#=" x 30, "\n";
print "#=" x 30, "\n";


__END__

my @namespaces = qw(
    main
    RPerl::DataStructure::GSLMatrix
    RPerl::DataStructure::GSLMatrix_cpp
    RPerl::Operation::Expression::Operator::GSLFunctions;
    RPerl::Operation::Expression::Operator::GSLFunctions_cpp;
);

foreach my $namespace (@namespaces) {
    print 'BEGIN NAMESPACE: ', $namespace, "\n\n";

    foreach my $entry ( sort keys %{$namespace . '::'} )
    {
        print $namespace, '::', $entry, "\n";
    
        print "\tscalar is defined\n" if defined ${$entry};
        print "\tarray  is defined\n" if @{$entry};
            print "\thash   is defined\n" if keys %{$entry};
        print "\tsub    is defined\n" if defined &{$entry};
        print "-" x 30, "\n";
    }

    print 'END NAMESPACE: ', $namespace, "\n\n";
    print "=" x 30, "\n";
}
