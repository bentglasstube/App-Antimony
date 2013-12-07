package Antimony::Module::File;

use strict;
use warnings;

use base 'Antimony::Module';

use IO::File;

__PACKAGE__->add_config(
  interval => { default => 1 },
  file => {
    default => '/home/alan/.notice',
  },
);

sub run {
  my ($self) = @_;

  my $file = IO::File->new($self->config('file'), 'r') or return undef;

  my $line = $file->getline;
  chomp $line;
  return $line;
}

1;
