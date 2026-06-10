package Samizdat::Controller::Skeleton;

use Mojo::Base 'Mojolicious::Controller', -signatures;

# Controllers return JSON for data; a GET that does not accept application/json is
# rendered into the static cache. Keep logic in the model (the `skeleton` helper).
sub index ($self) {
  if (($self->req->headers->accept // '') =~ /json/) {
    return $self->render(json => { items => $self->app->skeleton->get });
  }
  $self->render(template => 'skeleton/index');
}

1;
