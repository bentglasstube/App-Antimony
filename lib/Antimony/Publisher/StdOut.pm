package Antimony::Publisher::StdOut;

use strict;
use warnings;

use base 'Antimony::Publisher';

sub publish {
  my ($self, $string) = @_;

  print $string, "\n";
}

1;
