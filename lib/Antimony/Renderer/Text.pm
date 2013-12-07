package Antimony::Renderer::Text;

use strict;
use warnings;

use base 'Antimony::Renderer';

__PACKAGE__->add_config(
  max_length => {
    validator => qr/^\d+$/,
    default => 160,
  },
  ellipsis => {
    default => '...',
  },
  separator => {
    default => ' | ',
  },
);

sub render {
  my ($self, @strings) = @_;

  my $offset = $self->config('max_length') - length $self->config('ellipsis');

  foreach (@strings) {
    substr($_, $offset) = $self->config('ellipsis')
      if length $_ > $self->config('max_length');
  }

  return join $self->config('separator'), @strings;
}

1;
