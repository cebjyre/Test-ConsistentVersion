use Test::Builder::Tester tests => 2;
use Test::More;

eval { require Test::Pod::Content; };
SKIP: {
    skip "Can't test pod version without Test::Pod::Content", 2 if $@;
    
    use Test::ConsistentVersion;
    my $test_count = 1;
    
    my $good_dist_modules = [
        'Sample::Good',
        'Sample::StillGood',
    ];
    
    my $bad_dist_modules = [
        'Sample::Bad',
        'Sample::StillBad',
    ];
    
    chdir 't/Sample-Good';
    use lib 'lib';
    test_out(sprintf 'ok %d - %s POD version is the same as module version', $test_count++, $_) foreach @$good_dist_modules;
    Test::ConsistentVersion::_check_pod_versions(@$good_dist_modules);
    test_test();
    
    chdir '../Sample-Bad';
    use lib 'lib';
    test_out('not ok 1 - Sample::Bad POD version is the same as module version');
    test_out('ok 2 - Sample::StillBad POD version is the same as module version');
    test_err(q{#   Failed test 'Sample::Bad POD version is the same as module version'});
    test_err('/#\s+at\ .*?Test\/Pod\/Content\.pm line \d+\./');
    test_err('/#.*?\n.*doesn\'t match .*\n?/');
    Test::ConsistentVersion::_check_pod_versions(@$bad_dist_modules);
    test_test();
}

