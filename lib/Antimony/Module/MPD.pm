package Antimony::Module::MPD;

use strict;
use warnings;

use base 'Antimony::Module';

use Net::MPD;

__PACKAGE__->add_config(
  format => {
    default => '{Artist} - {Title}',
  },
  interval => {
    default => 1,
  },
);

sub run {
  my ($self) = @_;

  my $mpd = Net::MPD->connect() or return undef;
  my $info = $mpd->current_song();

  my $string = $self->config('format');
  $string =~ s/{(\w+)}/$info->{$1}/eg;

  return $string;
}

1;
