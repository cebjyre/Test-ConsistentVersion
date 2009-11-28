use Test::Builder::Tester tests => 3;
use Test::More;

my $good_version = '1.2.31';
my $bad_version = '1.2.32';
use Test::ConsistentVersion;

chdir 't/Sample-Good';

test_out('ok 1 - Changelog includes reference to the distribution version: ' . $good_version);
Test::ConsistentVersion::_check_changelog({version => $good_version});
test_test();

test_out('not ok 1 - Changelog includes reference to the distribution version: ' . $bad_version);
test_fail(1);
Test::ConsistentVersion::_check_changelog({version => $bad_version});
test_err(q{/#\s+'Changelog(.*\n.*)*doesn't match.*/});
test_test();

chdir '..';

test_out('not ok 1 - Unable to find Changes file');
test_fail(1);
Test::ConsistentVersion::_check_changelog({version => $good_version});
test_test();
