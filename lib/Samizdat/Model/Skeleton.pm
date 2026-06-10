package Samizdat::Model::Skeleton;

use Mojo::Base -base, -signatures;

has 'config';   # this module's resolved settings slice
has 'pg';       # core Mojo::Pg handle (may be undef if Pg isn't loaded)

sub get ($self, $params = {}) {
  # return $self->pg->db->query('SELECT * FROM skeleton.items')->hashes->to_array
  #   if $self->pg;
  return [];
}

1;
