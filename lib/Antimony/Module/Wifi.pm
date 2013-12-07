package Antimony::Module::Wifi;

use strict;
use warnings;

use base 'Antimony::Module';


__PACKAGE__->add_config(
  interval => {
    default => 1,
  },
);

sub run {
  my ($self) = @_;

  # TODO implement module
}

1;
