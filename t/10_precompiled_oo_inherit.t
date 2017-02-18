#!/usr/bin/perl

# START HERE: fix bugs...
# START HERE: fix bugs...
# START HERE: fix bugs...

# NEED FIX: Use of uninitialized value $type in hash element at (eval 1630) line 30. ...etc
# NEED FIX: Subroutine RPerl::Algorithm::inherited__Algorithm redefined at /usr/lib/perl/5.18/DynaLoader.pm line 207. ...etc

# [[[ PRE-HEADER ]]]
# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s),
# also 'WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package' due to RPerl/Test/*/*Bad*.pm & RPerl/Test/*/*bad*.pl
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.006_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireCheckingReturnValueOfEval)  ## SYSTEM DEFAULT 4: allow eval() test code blocks

# [[[ INCLUDES ]]]
use Test::More; # tests => 251;  # NEED RE-ENABLE
use Test::Exception;
use RPerl::Test;
use File::Copy;
use Module::Refresh;

# [[[ OPERATIONS ]]]

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag('[[[ Beginning Class Inheritance Pre-Test Loading, RPerl Object System ]]]');
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); }, q{use_ok('RPerl::AfterSubclass') lives} );
    lives_and( sub { use_ok('RPerl::Compiler'); }, q{use_ok('RPerl::Compiler') lives} );

    # NEED ANSWER: why does all this code have to be inside a BEGIN block???

    # NEED FIX: duplicate code, is it redundant to do this here and also at the top of the main for() loop?
    my string $bubble_cpp_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.cpp' );
    my string $bubble_h_filename   = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.h' );
    my string $bubble_pmc_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc' );

    my string $sort_cpp_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.cpp' );
    my string $sort_h_filename   = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.h' );
    my string $sort_pmc_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.pmc' );

    my string $inefficient_cpp_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.cpp' );
    my string $inefficient_h_filename   = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.h' );
    my string $inefficient_pmc_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.pmc' );

    my string $algorithm_cpp_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.cpp' );
    my string $algorithm_h_filename   = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.h' );
    my string $algorithm_pmc_filename = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.pmc' );

    #    RPerl::diag('in 10_precompiled_oo_inherit.t, have $bubble_pmc_filename = ' . $bubble_pmc_filename . "\n");

    # NEED FIX: triplicate code, is it redundant to do this here and also at the top of the main for() loop?
    # delete CPP, H, and PMC files if they exist;
    # for PERLOPS_PERLTYPES we need none of these files; for CPPOPS_xTYPES we need the proper manually-compiled files, not some other files
    foreach my string $filename (
        @{  [   $bubble_cpp_filename,      $bubble_h_filename,      $bubble_pmc_filename,      $sort_cpp_filename,
                $sort_h_filename,          $sort_pmc_filename,      $inefficient_cpp_filename, $inefficient_h_filename,
                $inefficient_pmc_filename, $algorithm_cpp_filename, $algorithm_h_filename,     $algorithm_pmc_filename
            ]
        }
        )
    {
        if ( -e $filename ) {
            my integer $unlink_success = unlink $filename;
            if ($unlink_success) {
                ok( 1, 'Unlink (delete) existing file ' . $filename );
            }
            else {
                ok( 0, 'Unlink (delete) existing file ' . $filename . q{ ... } . $OS_ERROR );

                # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
                next;
            }
        }
        else {
            ok( 1, 'No need to unlink (delete) existing file ' . $filename );
        }
    }




    # DEV NOTE, CORRELATION #rp015: suppress 'Too late to run INIT block' at run-time loading via require or eval
    lives_and( sub { require_ok('RPerl::Algorithm::Sort::Bubble'); }, q{require_ok('RPerl::Algorithm::Sort::Bubble') lives} );
    lives_and( sub { require_ok('RPerl::Algorithm::Inefficient'); },  q{require_ok('RPerl::Algorithm::Inefficient') lives} );
}









my string $bubble_pm_filename      = 'RPerl/Algorithm/Sort/Bubble.pm';
my string $sort_pm_filename        = 'RPerl/Algorithm/Sort.pm';
my string $inefficient_pm_filename = 'RPerl/Algorithm/Inefficient.pm';
my string $algorithm_pm_filename   = 'RPerl/Algorithm.pm';
my object $refresher               = Module::Refresh->new();

# NEED FIX: duplicate code
my string $bubble_cpp_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.cpp' );
my string $bubble_cpp_filename_manual = $bubble_cpp_filename . '.CPPOPS_DUALTYPES';
#my string $bubble_cpp_filename_manual = $bubble_cpp_filename . '.CPPOPS_CPPTYPES';
my string $bubble_h_filename          = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.h' );
my string $bubble_h_filename_manual   = $bubble_h_filename . '.CPPOPS_DUALTYPES';
#my string $bubble_h_filename_manual   = $bubble_h_filename . '.CPPOPS_CPPTYPES';
my string $bubble_pmc_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort/Bubble.pmc' );
my string $bubble_pmc_filename_manual = $bubble_pmc_filename . '.CPPOPS_DUALTYPES';

my string $sort_cpp_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.cpp' );
my string $sort_cpp_filename_manual = $sort_cpp_filename . '.CPPOPS_DUALTYPES';
#my string $sort_cpp_filename_manual = $sort_cpp_filename . '.CPPOPS_CPPTYPES';
my string $sort_h_filename          = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.h' );
my string $sort_h_filename_manual   = $sort_h_filename . '.CPPOPS_DUALTYPES';
#my string $sort_h_filename_manual   = $sort_h_filename . '.CPPOPS_CPPTYPES';
my string $sort_pmc_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Sort.pmc' );
my string $sort_pmc_filename_manual = $sort_pmc_filename . '.CPPOPS_DUALTYPES';

my string $inefficient_cpp_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.cpp' );
my string $inefficient_cpp_filename_manual = $inefficient_cpp_filename . '.CPPOPS_DUALTYPES';
#my string $inefficient_cpp_filename_manual = $inefficient_cpp_filename . '.CPPOPS_CPPTYPES';
my string $inefficient_h_filename          = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.h' );
my string $inefficient_h_filename_manual   = $inefficient_h_filename . '.CPPOPS_DUALTYPES';
#my string $inefficient_h_filename_manual   = $inefficient_h_filename . '.CPPOPS_CPPTYPES';
my string $inefficient_pmc_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm/Inefficient.pmc' );
my string $inefficient_pmc_filename_manual = $inefficient_pmc_filename . '.CPPOPS_DUALTYPES';

my string $algorithm_cpp_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.cpp' );
my string $algorithm_cpp_filename_manual = $algorithm_cpp_filename . '.CPPOPS_DUALTYPES';
#my string $algorithm_cpp_filename_manual = $algorithm_cpp_filename . '.CPPOPS_CPPTYPES';
my string $algorithm_h_filename          = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.h' );
my string $algorithm_h_filename_manual   = $algorithm_h_filename . '.CPPOPS_DUALTYPES';
#my string $algorithm_h_filename_manual   = $algorithm_h_filename . '.CPPOPS_CPPTYPES';
my string $algorithm_pmc_filename        = RPerl::Compiler::post_processor__absolute_path_delete( $RPerl::INCLUDE_PATH . '/RPerl/Algorithm.pmc' );
my string $algorithm_pmc_filename_manual = $algorithm_pmc_filename . '.CPPOPS_DUALTYPES';

#RPerl::diag('in 10_precompiled_oo_inherit.t, have $bubble_pmc_filename = ' . $bubble_pmc_filename . "\n");
#RPerl::diag('in 10_precompiled_oo_inherit.t, have $bubble_pmc_filename_manual = ' . $bubble_pmc_filename_manual . "\n");

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
#foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {
for my integer $mode_id ( 0, 2 ) {    # TEMPORARY DEBUGGING xOPS_xTYPES ONLY

    # [[[ MODE SETUP ]]]
    #    RPerl::diag("in 10_precompiled_oo_inherit.t, top of for() loop, have \$mode_id = $mode_id\n");
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my $ops                     = $mode->{ops};
    my $types                   = $mode->{types};
    my string $mode_tagline     = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning Class Inheritance Tests, RPerl Object System, ' . $ops . ' Operations & ' . $types . ' Data Types' . ' ]]]' );
    }

    lives_ok( sub { rperltypes::types_enable($types) }, q{Mode '} . $ops . ' Operations & ' . $types . ' Data Types' . q{' enabled in CPP header file(s)} );

    # NEED FIX: triplicate code
    # delete CPP, H, and PMC files if they exist;
    # for PERLOPS_PERLTYPES we need none of these files; for CPPOPS_xTYPES we need the proper manually-compiled files, not some other files
    foreach my string $filename (
        @{  [   $bubble_cpp_filename,      $bubble_h_filename,      $bubble_pmc_filename,      $sort_cpp_filename,
                $sort_h_filename,          $sort_pmc_filename,      $inefficient_cpp_filename, $inefficient_h_filename,
                $inefficient_pmc_filename, $algorithm_cpp_filename, $algorithm_h_filename,     $algorithm_pmc_filename
            ]
        }
        )
    {
        if ( -e $filename ) {
            my integer $unlink_success = unlink $filename;
            if ($unlink_success) {
                ok( 1, 'Unlink (delete) existing file ' . $filename );
            }
            else {
                ok( 0, 'Unlink (delete) existing file ' . $filename . q{ ... } . $OS_ERROR );

                # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
                next;
            }
        }
        else {
            ok( 1, 'No need to unlink (delete) existing file ' . $filename );
        }
    }

    if ( $ops eq 'PERL' ) {

#        RPerl::diag('in 10_precompiled_oo_inherit.t, have Bubble symtab entries:' . "\n" . RPerl::analyze_class_symtab_entries('RPerl::Algorithm::Sort::Bubble') . "\n\n");
    }
    else {    # $ops eq 'CPP'
        foreach my string_arrayref $filenames (
            @{  [   [ $bubble_cpp_filename, $bubble_cpp_filename_manual ],

                    [ $bubble_h_filename,   $bubble_h_filename_manual ],
                    [ $bubble_pmc_filename, $bubble_pmc_filename_manual ],
                    [ $sort_cpp_filename,   $sort_cpp_filename_manual ],
                    [ $sort_h_filename,     $sort_h_filename_manual ],
                    [ $sort_pmc_filename,   $sort_pmc_filename_manual ],

                    [ $inefficient_cpp_filename, $inefficient_cpp_filename_manual ],
                    [ $inefficient_h_filename,   $inefficient_h_filename_manual ],
                    [ $inefficient_pmc_filename, $inefficient_pmc_filename_manual ],

                    [ $algorithm_cpp_filename, $algorithm_cpp_filename_manual ],
                    [ $algorithm_h_filename,   $algorithm_h_filename_manual ],
                    [ $algorithm_pmc_filename, $algorithm_pmc_filename_manual ]
                ]
            }
            )
        {
            my string $filename              = $filenames->[0];
            my string $filename_manual       = $filenames->[1];
            my string $filename_short        = $filename;
            my string $filename_manual_short = $filename_manual;
            if ( ( length $filename_short ) > 55 )        { $filename_short        = '...' . substr $filename_short,        -55; }
            if ( ( length $filename_manual_short ) > 55 ) { $filename_manual_short = '...' . substr $filename_manual_short, -55; }
            if ( -e ($filename_manual) ) {
                my integer $copy_success = copy( $filename_manual, $filename );
                if ($copy_success) {
                    ok( 1, 'Copy manually-compiled file ' . $filename_manual_short . ' to ' . $filename_short );
                }
                else {
                    ok( 0, 'Copy manually-compiled file ' . $filename_manual_short . ' to ' . $filename_short . q{ ... } . $OS_ERROR );
                }
            }
            else {
                ok( 0, 'Copy manually-compiled file ' . $filename_manual_short . ' to ' . $filename_short . q{ ... } . 'File does not exist' );
            }
        }

        # C++ use, load, link
        # ALL 4 MODULES
        lives_ok( sub { $refresher->refresh_module($bubble_pm_filename) },      'Refresh previously-loaded module: ' . $bubble_pm_filename );
        lives_ok( sub { $refresher->refresh_module($sort_pm_filename) },        'Refresh previously-loaded module: ' . $sort_pm_filename );
        lives_ok( sub { $refresher->refresh_module($inefficient_pm_filename) }, 'Refresh previously-loaded module: ' . $inefficient_pm_filename );
        lives_ok( sub { $refresher->refresh_module($algorithm_pm_filename) },   'Refresh previously-loaded module: ' . $algorithm_pm_filename );

        # DEV NOTE, CORRELATION #rp015: suppress 'Too late to run INIT block' at run-time loading via require or eval
        # ONLY 2 MODULES
        lives_and( sub { require_ok('RPerl::Algorithm::Sort::Bubble'); }, q{require_ok('RPerl::Algorithm::Sort::Bubble') lives} );
        lives_and( sub { require_ok('RPerl::Algorithm::Inefficient'); },  q{require_ok('RPerl::Algorithm::Inefficient') lives} );

        # force reload
        # ONLY 2 MODULES
        delete $main::{'RPerl__Algorithm__Sort__Bubble__MODE_ID'};
        delete $main::{'RPerl__Algorithm__Inefficient__MODE_ID'};

        # DEV NOTE: must call long form of cpp_load() to bypass mysterious 'undefined subroutine' symtab weirdness
        # ONLY 2 MODULES
        #lives_ok( sub { RPerl::Algorithm::Sort::Bubble::cpp_load(); }, q{RPerl::Algorithm::Sort::Bubble::cpp_load() lives} );
        lives_ok( sub { &{ $RPerl::Algorithm::Sort::Bubble::{'cpp_load'} }(); }, q{RPerl::Algorithm::Sort::Bubble::cpp_load() lives} );    # long form
        lives_ok( sub { &{ $RPerl::Algorithm::Inefficient::{'cpp_load'} }(); },  q{RPerl::Algorithm::Inefficient::cpp_load() lives} );     # long form

#RPerl::diag('in 10_precompiled_oo_inherit.t, have post-re-use, post-re-cpp_load Bubble symtab entries:' . "\n" . RPerl::analyze_class_symtab_entries('RPerl::Algorithm::Sort::Bubble') . "\n\n");
    }

    foreach my string $type (
        qw(DataType__Integer DataType__Number DataType__String DataStructure__Array DataStructure__Hash Algorithm Algorithm__Sort Algorithm__Inefficient Algorithm__Sort__Bubble)
        )
    {
        lives_and(
            sub {
                is( $RPerl::MODES->{ main->can( 'RPerl__' . $type . '__MODE_ID' )->() }->{ops},
                    $ops, 'main::RPerl__' . $type . '__MODE_ID() ops returns ' . $ops );
            },
            'main::RPerl__' . $type . '__MODE_ID() lives'
        );
        lives_and(
            sub {
                is( $RPerl::MODES->{ main->can( 'RPerl__' . $type . '__MODE_ID' )->() }->{types},
                    $types, 'main::RPerl__' . $type . '__MODE_ID() types returns ' . $types );
            },
            'main::RPerl__' . $type . '__MODE_ID() lives'
        );
    }

    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]
    # [[[ OO INHERITANCE TESTS ]]]

    # [ BUBBLE ]

    # TOOIN00
    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'new' );
    my $bubbler = new_ok('RPerl::Algorithm::Sort::Bubble');

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Bubble' );
    lives_ok(    # TOOIN01
        sub { $bubbler->inherited__Bubble('Frozen') },
        q{TOOIN01 inherited__Bubble('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Sort' );
    lives_ok(    # TOOIN02
        sub { $bubbler->inherited__Sort('Frozen') },
        q{TOOIN02 inherited__Sort('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Algorithm' );
    lives_ok(    # TOOIN03
        sub { $bubbler->inherited__Algorithm('Frozen') },
        q{TOOIN03 inherited__Algorithm('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited' );
    lives_ok(    # TOOIN04
        sub { $bubbler->inherited('Logan') },
        q{TOOIN04 inherited('Logan') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'uninherited__Bubble' );
    lives_and(    # TOOIN05
        sub {
            is( RPerl::Algorithm::Sort::Bubble::uninherited__Bubble('Claws'),
                'Bubble::uninherited__Bubble() RULES! ' . $mode_tagline,
                q{TOOIN05 uninherited__Bubble('Claws') returns correct value}
            );
        },
        q{TOOIN05 uninherited__Bubble('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'uninherited' );
    lives_and(    # TOOIN06
        sub {
            is( RPerl::Algorithm::Sort::Bubble::uninherited('Wolverine'),
                'Bubble::uninherited() ROCKS! ' . $mode_tagline,
                q{TOOIN06 uninherited('Wolverine') returns correct value}
            );
        },
        q{TOOIN06 uninherited('Wolverine') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'get_foo' );
    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'set_foo' );
    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Bubble_foo_get' );
    lives_and(    # TOOIN07 - TOOIN11
        sub {
            is( $bubbler->get_foo(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN07 get_foo() returns correct value}
            );
            is( $bubbler->inherited__Bubble_foo_get(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN08 inherited__Bubble_foo_get() returns correct value}
            );
            $bubbler->set_foo('Alpha Flight');
            is( $bubbler->get_foo(),
                'Alpha Flight',
                q{TOOIN09 set_foo('Alpha Flight') sets correct value}
            );
            is( $bubbler->inherited__Bubble_foo_get(),
                'Alpha Flight',
                q{TOOIN10 inherited__Bubble_foo_get() returns correct value}
            );
        },
        q{TOOIN11 set_foo('Alpha Flight') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Bubble_foo_set' );
    lives_and(    # TOOIN12 - TOOIN16
        sub {
            is( $bubbler->get_foo(),
                'Alpha Flight',
                q{TOOIN12 get_foo() returns correct value}
            );
            is( $bubbler->inherited__Bubble_foo_get(),
                'Alpha Flight',
                q{TOOIN13 inherited__Bubble_foo_get() returns correct value}
            );
            $bubbler->inherited__Bubble_foo_set('Avengers');
            is( $bubbler->get_foo(),
                'Avengers',
                q{TOOIN14 inherited__Bubble_foo_set('Avengers') sets correct value}
            );
            is( $bubbler->inherited__Bubble_foo_get(),
                'Avengers',
                q{TOOIN15 inherited__Bubble_foo_get() returns correct value}
            );
        },
        q{TOOIN16 inherited__Bubble_foo_set('Avengers') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Sort_foo_get' );
    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Sort_foo_set' );
    lives_and(    # TOOIN17 - TOOIN21
        sub {
            is( $bubbler->get_foo(),
                'Avengers',
                q{TOOIN17 get_foo() returns correct value}
            );
            is( $bubbler->inherited__Sort_foo_get(),
                'Avengers',
                q{TOOIN18 inherited__Sort_foo_get() returns correct value}
            );
            $bubbler->inherited__Sort_foo_set('X-Men');
            is( $bubbler->get_foo(),
                'X-Men',
                q{TOOIN19 inherited__Sort_foo_set('X-Men') sets correct value}
            );
            is( $bubbler->inherited__Sort_foo_get(),
                'X-Men',
                q{TOOIN20 inherited__Sort_foo_get() returns correct value}
            );
        },
        q{TOOIN21 inherited__Sort_foo_set('X-Men') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Algorithm_foo_get' );
    can_ok( 'RPerl::Algorithm::Sort::Bubble', 'inherited__Algorithm_foo_set' );
    lives_and(    # TOOIN22 - TOOIN
        sub {
            is( $bubbler->get_foo(),
                'X-Men',
                q{TOOIN22 get_foo() returns correct value}
            );
            is( $bubbler->inherited__Algorithm_foo_get(),
                'X-Men',
                q{TOOIN23 inherited__Algorithm_foo_get() returns correct value}
            );
            $bubbler->inherited__Algorithm_foo_set('Weapon X');
            is( $bubbler->get_foo(),
                'Weapon X',
                q{TOOIN24 inherited__Algorithm_foo_set('Weapon X') sets correct value}
            );
            is( $bubbler->inherited__Algorithm_foo_get(),
                'Weapon X',
                q{TOOIN25 inherited__Algorithm_foo_get() returns correct value}
            );
        },
        q{TOOIN26 inherited__Algorithm_foo_set('Weapon X') lives}
    );


    # [ SORT ]

    # TOOIN27
    can_ok( 'RPerl::Algorithm::Sort', 'new' );
    my $sorter = new_ok('RPerl::Algorithm::Sort');

    can_ok( 'RPerl::Algorithm::Sort', 'uninherited__Sort' );
    lives_and(    # TOOIN28
        sub {
            is( RPerl::Algorithm::Sort::uninherited__Sort('Claws'),
                'Sort::uninherited__Sort() RULES! ' . $mode_tagline,
                q{TOOIN28 uninherited__Sort('Claws') returns correct value}
            );
        },
        q{TOOIN28 uninherited__Sort('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort', 'inherited__Sort' );
    lives_ok(    # TOOIN29
        sub { $sorter->inherited__Sort('Frozen') },
        q{TOOIN29 inherited__Sort('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort', 'inherited__Algorithm' );
    lives_ok(    # TOOIN30
        sub { $sorter->inherited__Algorithm('Frozen') },
        q{TOOIN30 inherited__Algorithm('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort', 'get_foo' );
    can_ok( 'RPerl::Algorithm::Sort', 'set_foo' );
    can_ok( 'RPerl::Algorithm::Sort', 'inherited__Sort_foo_get' );
    lives_and(    # TOOIN31 - TOOIN35
        sub {
            is( $sorter->get_foo(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN31 get_foo() returns correct value}
            );
            is( $sorter->inherited__Sort_foo_get(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN32 inherited__Sort_foo_get() returns correct value}
            );
            $sorter->set_foo('Alpha Flight');
            is( $sorter->get_foo(),
                'Alpha Flight',
                q{TOOIN33 set_foo('Alpha Flight') sets correct value}
            );
            is( $sorter->inherited__Sort_foo_get(),
                'Alpha Flight',
                q{TOOIN34 inherited__Sort_foo_get() returns correct value}
            );
        },
        q{TOOIN35 set_foo('Alpha Flight') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort', 'inherited__Sort_foo_set' );
    lives_and(    # TOOIN36 - TOOIN40
        sub {
            is( $sorter->get_foo(),
                'Alpha Flight',
                q{TOOIN36 get_foo() returns correct value}
            );
            is( $sorter->inherited__Sort_foo_get(),
                'Alpha Flight',
                q{TOOIN37 inherited__Sort_foo_get() returns correct value}
            );
            $sorter->inherited__Sort_foo_set('Avengers');
            is( $sorter->get_foo(),
                'Avengers',
                q{TOOIN38 inherited__Sort_foo_set('Avengers') sets correct value}
            );
            is( $sorter->inherited__Sort_foo_get(),
                'Avengers',
                q{TOOIN39 inherited__Sort_foo_get() returns correct value}
            );
        },
        q{TOOIN40 inherited__Sort_foo_set('Avengers') lives}
    );

    can_ok( 'RPerl::Algorithm::Sort', 'inherited__Algorithm_foo_get' );
    can_ok( 'RPerl::Algorithm::Sort', 'inherited__Algorithm_foo_set' );
    lives_and(    # TOOIN41 - TOOIN45
        sub {
            is( $sorter->get_foo(),
                'Avengers',
                q{TOOIN41 get_foo() returns correct value}
            );
            is( $sorter->inherited__Algorithm_foo_get(),
                'Avengers',
                q{TOOIN42 inherited__Algorithm_foo_get() returns correct value}
            );
            $sorter->inherited__Algorithm_foo_set('X-Men');
            is( $sorter->get_foo(),
                'X-Men',
                q{TOOIN43 inherited__Algorithm_foo_set('X-Men') sets correct value}
            );
            is( $sorter->inherited__Algorithm_foo_get(),
                'X-Men',
                q{TOOIN44 inherited__Algorithm_foo_get() returns correct value}
            );
        },
        q{TOOIN45 inherited__Algorithm_foo_set('X-Men') lives}
    );


    # [ INEFFICIENT ]

    # TOOIN46
    can_ok( 'RPerl::Algorithm::Inefficient', 'new' );
    my $inefficient = new_ok('RPerl::Algorithm::Inefficient');

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Inefficient' );
    lives_ok(    # TOOIN47
        sub { $inefficient->inherited__Inefficient('Frozen') },
        q{TOOIN47 inherited__Inefficient('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Algorithm' );
    lives_ok(    # TOOIN48
        sub { $inefficient->inherited__Algorithm('Frozen') },
        q{TOOIN48 inherited__Algorithm('Frozen') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited' );
    lives_ok(    # TOOIN49
        sub { $inefficient->inherited('Logan') },
        q{TOOIN49 inherited('Logan') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'uninherited__Inefficient' );
    lives_and(    # TOOIN50
        sub {
            is( RPerl::Algorithm::Inefficient::uninherited__Inefficient('Claws'),
                'Inefficient::uninherited__Inefficient() RULES! ' . $mode_tagline,
                q{TOOIN50 uninherited__Inefficient('Claws') returns correct value}
            );
        },
        q{TOOIN50 uninherited__Inefficient('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'get_foo' );
    can_ok( 'RPerl::Algorithm::Inefficient', 'set_foo' );
    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Inefficient_foo_get' );
    lives_and(    # TOOIN51 - TOOIN55
        sub {
            is( $inefficient->get_foo(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN51 get_foo() returns correct value}
            );
            is( $inefficient->inherited__Inefficient_foo_get(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN52 inherited__Inefficient_foo_get() returns correct value}
            );
            $inefficient->set_foo('Alpha Flight');
            is( $inefficient->get_foo(),
                'Alpha Flight',
                q{TOOIN53 set_foo('Alpha Flight') sets correct value}
            );
            is( $inefficient->inherited__Inefficient_foo_get(),
                'Alpha Flight',
                q{TOOIN54 inherited__Inefficient_foo_get() returns correct value}
            );
        },
        q{TOOIN55 set_foo('Alpha Flight') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Inefficient_foo_set' );
    lives_and(    # TOOIN56 - TOOIN60
        sub {
            is( $inefficient->get_foo(),
                'Alpha Flight',
                q{TOOIN56 get_foo() returns correct value}
            );
            is( $inefficient->inherited__Inefficient_foo_get(),
                'Alpha Flight',
                q{TOOIN57 inherited__Inefficient_foo_get() returns correct value}
            );
            $inefficient->inherited__Inefficient_foo_set('Avengers');
            is( $inefficient->get_foo(),
                'Avengers',
                q{TOOIN58 inherited__Inefficient_foo_set('Avengers') sets correct value}
            );
            is( $inefficient->inherited__Inefficient_foo_get(),
                'Avengers',
                q{TOOIN59 inherited__Inefficient_foo_get() returns correct value}
            );
        },
        q{TOOIN60 inherited__Inefficient_foo_set('Avengers') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'get_bar' );
    can_ok( 'RPerl::Algorithm::Inefficient', 'set_bar' );
    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Inefficient_bar_get' );
    lives_and(    # TOOIN61 - TOOIN65
        sub {
            is( $inefficient->get_bar(),
                '<<< DEFAULT, INEFFICIENT >>>',
                q{TOOIN61 get_bar() returns correct value}
            );
            is( $inefficient->inherited__Inefficient_bar_get(),
                '<<< DEFAULT, INEFFICIENT >>>',
                q{TOOIN62 inherited__Inefficient_bar_get() returns correct value}
            );
            $inefficient->set_bar('Alpha Flight');
            is( $inefficient->get_bar(),
                'Alpha Flight',
                q{TOOIN63 set_bar('Alpha Flight') sets correct value}
            );
            is( $inefficient->inherited__Inefficient_bar_get(),
                'Alpha Flight',
                q{TOOIN64 inherited__Inefficient_bar_get() returns correct value}
            );
        },
        q{TOOIN65 inherited__Inefficient_bar_set('Alpha Flight') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Inefficient_bar_set' );
    lives_and(    # TOOIN66 - TOOIN70
        sub {
            is( $inefficient->get_bar(),
                'Alpha Flight',
                q{TOOIN66 get_bar() returns correct value}
            );
            is( $inefficient->inherited__Inefficient_bar_get(),
                'Alpha Flight',
                q{TOOIN67 inherited__Inefficient_bar_get() returns correct value}
            );
            $inefficient->inherited__Inefficient_bar_set('Avengers');
            is( $inefficient->get_bar(),
                'Avengers',
                q{TOOIN68 inherited__Inefficient_bar_set('Avengers') sets correct value}
            );
            is( $inefficient->inherited__Inefficient_bar_get(),
                'Avengers',
                q{TOOIN69 inherited__Inefficient_bar_get() returns correct value}
            );
        },
        q{TOOIN70 inherited__Inefficient_bar_set('Avengers') lives}
    );

    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Algorithm_foo_get' );
    can_ok( 'RPerl::Algorithm::Inefficient', 'inherited__Algorithm_foo_set' );
    lives_and(    # TOOIN71 - TOOIN75
        sub {
            is( $inefficient->get_foo(),
                'Avengers',
                q{TOOIN71 get_foo() returns correct value}
            );
            is( $inefficient->inherited__Algorithm_foo_get(),
                'Avengers',
                q{TOOIN72 inherited__Algorithm_foo_get() returns correct value}
            );
            $inefficient->inherited__Algorithm_foo_set('X-Men');
            is( $inefficient->get_foo(),
                'X-Men',
                q{TOOIN73 inherited__Algorithm_foo_set('X-Men') sets correct value}
            );
            is( $inefficient->inherited__Algorithm_foo_get(),
                'X-Men',
                q{TOOIN74 inherited__Algorithm_foo_get() returns correct value}
            );
        },
        q{TOOIN75 inherited__Algorithm_foo_set('X-Men') lives}
    );


    # [ ALGORITHM ]

    # TOOIN76
    can_ok( 'RPerl::Algorithm', 'new' );
    my $algorithm = new_ok('RPerl::Algorithm');

    can_ok( 'RPerl::Algorithm', 'uninherited__Algorithm' );
    lives_and(    # TOOIN77
        sub {
            is( RPerl::Algorithm::uninherited__Algorithm('Claws'),
                'Algorithm::uninherited__Algorithm() RULES! ' . $mode_tagline,
                q{TOOIN77 uninherited__Algorithm('Claws') returns correct value}
            );
        },
        q{TOOIN77 uninherited__Algorithm('Claws') lives}
    );

    can_ok( 'RPerl::Algorithm', 'get_foo' );
    can_ok( 'RPerl::Algorithm', 'set_foo' );
    can_ok( 'RPerl::Algorithm', 'inherited__Algorithm_foo_get' );
    lives_and(    # TOOIN78 - TOOIN82
        sub {
            is( $algorithm->get_foo(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN78 get_foo() returns correct value}
            );
            is( $algorithm->inherited__Algorithm_foo_get(),
                '<<< DEFAULT, ALGORITHM >>>',
                q{TOOIN79 inherited__Algorithm_foo_get() returns correct value}
            );
            $algorithm->set_foo('Alpha Flight');
            is( $algorithm->get_foo(),
                'Alpha Flight',
                q{TOOIN80 set_foo('Alpha Flight') sets correct value}
            );
            is( $algorithm->inherited__Algorithm_foo_get(),
                'Alpha Flight',
                q{TOOIN81 inherited__Algorithm_foo_get() returns correct value}
            );
        },
        q{TOOIN82 set_foo('Alpha Flight') lives}
    );

    can_ok( 'RPerl::Algorithm', 'inherited__Algorithm_foo_set' );
    lives_and(    # TOOIN83 - TOOIN87
        sub {
            is( $algorithm->get_foo(),
                'Alpha Flight',
                q{TOOIN83 get_foo() returns correct value}
            );
            is( $algorithm->inherited__Algorithm_foo_get(),
                'Alpha Flight',
                q{TOOIN84 inherited__Algorithm_foo_get() returns correct value}
            );
            $algorithm->inherited__Algorithm_foo_set('Avengers');
            is( $algorithm->get_foo(),
                'Avengers',
                q{TOOIN85 inherited__Algorithm_foo_set('Avengers') sets correct value}
            );
            is( $algorithm->inherited__Algorithm_foo_get(),
                'Avengers',
                q{TOOIN86 inherited__Algorithm_foo_get() returns correct value}
            );
        },
        q{TOOIN87 inherited__Algorithm_foo_set('Avengers') lives}
    );

   # DEV NOTE, CORRELATION #rp004: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
   #    can_ok( 'RPerl::Algorithm::Inefficient', 'uninherited' );
   #    lives_and(    # TOOINxx
   #        sub {
   #            is( uninherited('Wolverine'), 'Inefficient::uninherited() ROCKS! ' . $mode_tagline, q{TOOINxx uninherited('Wolverine') returns correct value} );
   #        },
   #        q{TOOINxx uninherited('Wolverine') lives}
   #    );

}

# NEED FIX: triplicate code
# delete CPP, H, and PMC files if they exist;
# for PERLOPS_PERLTYPES we need none of these files; for CPPOPS_xTYPES we need the proper manually-compiled files, not some other files
foreach my string $filename (
    @{  [   $bubble_cpp_filename,      $bubble_h_filename,      $bubble_pmc_filename,      $sort_cpp_filename,
            $sort_h_filename,          $sort_pmc_filename,      $inefficient_cpp_filename, $inefficient_h_filename,
            $inefficient_pmc_filename, $algorithm_cpp_filename, $algorithm_h_filename,     $algorithm_pmc_filename
        ]
    }
    )
{
    {
        if ( -e $filename ) {
            my integer $unlink_success = unlink $filename;
            if ($unlink_success) {
                ok( 1, 'Unlink (delete) existing file ' . $filename );
            }
            else {
                ok( 0, 'Unlink (delete) existing file ' . $filename . q{ ... } . $OS_ERROR );

                # skip all tests in this mode if we cannot remove the PMC file (and presumably the other 2 modes, as well)
                next;
            }
        }
        else {
            ok( 1, 'No need to unlink (delete) existing file ' . $filename );
        }
    }
}

done_testing();
