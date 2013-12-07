package Antimony::Module::Clock;

use strict;
use warnings;

use base 'Antimony::Module';

use DateTime;

__PACKAGE__->add_config(
  date_format => {
    default => '%c',
  },
  time_zome => {
    default => 'local',
  },
  interval => {
    default => 1,
  },
);

sub run {
  my ($self) = @_;

  my $dt = DateTime->now(time_zone => $self->config('time_zome'));
  return $dt->strftime($self->config('date_format'));
}

1;
