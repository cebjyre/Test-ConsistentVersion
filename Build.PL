use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Test::ConsistentVersion',
    license             => 'perl',
    dist_author         => 'Glenn Fowler <cebjyre@cpan.org>',
    dist_version_from   => 'lib/Test/ConsistentVersion.pm',
    requires => {
        'Test::Builder' => 0,
        'version'       => 0,
        'autodie'       => 0,
    },
    add_to_cleanup      => [ 'Test-ConsistentVersion-*' ],
);

$builder->create_build_script();
