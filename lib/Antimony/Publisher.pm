package Antimony::Publisher;

use strict;
use warnings;

use base 'Antimony::Configurable';

use Carp 'croak';

sub publish {
  my ($self, $string) = @_;

  croak 'Base publisher implementation';
}

1;
