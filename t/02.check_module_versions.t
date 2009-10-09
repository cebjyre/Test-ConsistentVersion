use Test::Builder::Tester tests => 2;

use version;
my $dist_version = qv('1.2.31');

my $good_dist_modules = [
    'Sample::Good',
    'Sample::StillGood',
];

my $bad_dist_modules = [
    'Sample::Bad',
    'Sample::StillBad',
];

use Test::ConsistentVersion;

chdir 't/Sample-Good';
use lib 'lib';

my $test_count = 1;
test_out(sprintf 'ok %d - Sample::Good is the same as the distribution version', $test_count++);
test_out(sprintf 'ok %d - Sample::StillGood is the same as the distribution version', $test_count++);
Test::ConsistentVersion::_check_module_versions($dist_version, @$good_dist_modules);

test_test('Failing version check');

chdir '../Sample-Bad';
use lib 'lib';

$test_count = 1;
test_out(sprintf 'ok %d - Sample::Bad is the same as the distribution version', $test_count++);
test_out(sprintf 'not ok %d - Sample::StillBad is the same as the distribution version', $test_count++);

# Sample::StillBad has a different version number
test_err(q{#   Failed test 'Sample::StillBad is the same as the distribution version'});
test_err(q{#   at t/02.check_module_versions.t line 40.});
test_err(q{#          got: '1.2.30'});
test_err(q{#     expected: '1.2.31'});
Test::ConsistentVersion::_check_module_versions($dist_version, @$bad_dist_modules);

test_test('Failing version check');
