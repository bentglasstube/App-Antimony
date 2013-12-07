package Antimony::Renderer;

use strict;
use warnings;

use base 'Antimony::Configurable';

use Carp 'croak';

sub render {
  my ($self, @strings) = @_;

  croak 'Base renderer implementation';
}

1;
