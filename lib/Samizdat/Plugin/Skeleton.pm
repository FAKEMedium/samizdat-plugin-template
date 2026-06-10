package Samizdat::Plugin::Skeleton;

use Mojo::Base 'Mojolicious::Plugin', -signatures;
use Samizdat::Model::Skeleton;

# A Samizdat plugin registers routes and ONE model-backed helper. Use the
# $app->routes->manager / ->home shortcuts in real plugins; keep DB queries in the
# model (never in the controller). See the Samizdat docs.
sub register ($self, $app, $conf) {
  my $r = $app->routes;

  $r->get('/skeleton')->to(controller => 'Skeleton', action => 'index')->name('skeleton_index');

  # The helper owns its config slice via the layered settings resolver, and is given
  # the core pg handle only when the Pg plugin is loaded (guarded — keeps the dist
  # installable standalone).
  $app->helper(skeleton => sub ($c) {
    state $model = Samizdat::Model::Skeleton->new(
      config => $c->settings->resolve('skeleton'),
      pg     => ($app->renderer->helpers->{pg} ? $c->pg : undef),
    );
    return $model;
  });
}

1;

=head1 NAME

Samizdat::Plugin::Skeleton - a minimal Samizdat plugin (template)

=head1 DESCRIPTION

Starting skeleton for a Samizdat plugin distribution. Run C<./new-plugin.sh Yourname>
to rename C<Skeleton>/C<skeleton> throughout.

=cut
