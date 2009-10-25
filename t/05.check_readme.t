use Test::Builder::Tester tests => 2;
use Test::More;

my $good_version = '1.2.31';
my $bad_version = '1.2.32';
use Test::ConsistentVersion;

chdir 't/Sample-Good';

test_out('ok 1 - README file includes reference to the distribution version: ' . $good_version);
Test::ConsistentVersion::_check_readme($good_version);
test_test();

test_out('not ok 1 - README file includes reference to the distribution version: ' . $bad_version);
test_fail(1);
Test::ConsistentVersion::_check_readme($bad_version);
test_err(sprintf q{/#\s+'%s version (.*\n.*)*doesn't match.*/}, 'Sample-Good');
test_test();
