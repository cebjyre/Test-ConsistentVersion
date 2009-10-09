use Test::More tests => 3;

my $good_dist_modules = [
    'Sample::Good',
    'Sample::StillGood',
];

my $one_bad_dist_module = [
    'Sample::StillBad',
];

use Test::ConsistentVersion;

chdir 't/Sample-Good';
my @modules = Test::ConsistentVersion::_find_modules();

is_deeply(\@modules, $good_dist_modules, 'Finding modules based on MANIFEST');

chdir '../Sample-Bad';
use lib 'lib';
Test::ConsistentVersion::check_consistent_versions(modules => $one_bad_dist_module, no_readme => 1, no_pod => 1, no_changelog => 1);
@modules = Test::ConsistentVersion::_find_modules();

is_deeply(\@modules, $one_bad_dist_module, 'Correctly using modules provided in args');