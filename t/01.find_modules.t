use Test::More tests => 3;

my $good_dist_modules = [
    'Sample::Good',
    'Sample::StillGood',
];

my $one_bad_dist_module = [
    'Sample::StillBad',
];

my $no_modules = [];

use Test::ConsistentVersion;

chdir 't/Sample-Good';
my @modules = Test::ConsistentVersion::_find_modules({});

is_deeply(\@modules, $good_dist_modules, 'Finding modules based on MANIFEST');

chdir '../Sample-Bad';
use lib 'lib';
@modules = Test::ConsistentVersion::_find_modules({modules => $one_bad_dist_module});

is_deeply(\@modules, $one_bad_dist_module, 'Correctly using modules provided in args');

chdir '..';
@modules = Test::ConsistentVersion::_find_modules({});

is_deeply(\@modules, $no_modules, 'Fallback to empty list if nothing better is available');
