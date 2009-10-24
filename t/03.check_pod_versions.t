use Test::Builder::Tester tests => 2;
use Test::More;

eval { require Test::Pod::Content; };
SKIP: {
    skip "Can't test pod version without Test::Pod::Content", 2 if $@;
    ok(1);
    ok(1);
}

