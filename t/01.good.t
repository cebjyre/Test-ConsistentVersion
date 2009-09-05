chdir 't/Sample-Good';
use lib 'lib';

use Test::More tests => 2;

my $test_count;
use Test::ConsistentVersion;
subtest check_good_distro => sub {
    Test::ConsistentVersion::check_consistent_versions;
    my $TEST = Test::Builder->new();
    $test_count = $TEST->current_test();
};

is($test_count, 5, 'Expected number of tests were performed');

