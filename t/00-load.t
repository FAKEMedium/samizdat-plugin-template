use strict;
use warnings;
use Test::More;

# Core (Samizdat) must be on @INC (PERL5LIB) at test time.
use_ok('Samizdat::Model::Skeleton');
use_ok('Samizdat::Controller::Skeleton');
use_ok('Samizdat::Plugin::Skeleton');

use File::Spec;
use YAML::XS qw(LoadFile);
my ($res) = grep { -d } map { File::Spec->catdir($_, 'Samizdat', 'resources') } @INC;
ok($res, 'resources dir is on @INC') or diag "no Samizdat/resources under @INC";
ok(-d File::Spec->catdir($res, 'templates', 'skeleton'), 'templates ship');
ok(scalar(glob(File::Spec->catfile($res, 'migrations', 'pg', '*-skeleton', '*', 'up.sql'))),
   'pg migration ships (numbered-version-dir layout)');
my $schema = eval { LoadFile(File::Spec->catfile($res, 'settings', 'skeleton', 'schema.yml')) };
ok(ref $schema eq 'HASH', 'settings schema loads')
  and like($schema->{'x-samizdat-audience'}, qr/^(core|operator|offerable)$/, 'audience set');

done_testing;
