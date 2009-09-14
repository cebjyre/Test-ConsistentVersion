chdir 't/Sample-Good';
use lib 'lib';

use Test::More tests => 2;
my $expected_tests = 2;     #number of modules to check
$expected_tests *= 2 if eval {require Test::Pod::Content};
                            #double it if we are checking for pod versions
$expected_tests+=2;          #plus one for the Changelog

my $test_count;
use Test::ConsistentVersion;
subtest check_good_distro => sub {
    Test::ConsistentVersion::check_consistent_versions;
    my $TEST = Test::Builder->new();
    $test_count = $TEST->current_test();
};

is($test_count, $expected_tests, "Expected number of tests ($expected_tests) were performed");

