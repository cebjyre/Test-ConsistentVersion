use Test::Builder::Tester tests => 2;
use Test::More;

my $good_version = '1.2.31';
my $bad_version = '1.2.32';
use Test::ConsistentVersion;

chdir 't/Sample-Good';

test_out('ok 1 - Changelog includes reference to the distribution version: ' . $good_version);
Test::ConsistentVersion::_check_changelog($good_version);
test_test();

test_out('not ok 1 - Changelog includes reference to the distribution version: ' . $bad_version);
test_fail(1);
Test::ConsistentVersion::_check_changelog($bad_version);
test_err(q{/#\s+'Changelog(.*\n.*)*doesn't match.*/});
test_test();
