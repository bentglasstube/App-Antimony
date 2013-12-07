package Antimony::Module;

use strict;
use warnings;
use threads;

use Carp 'croak';

use base 'Antimony::Configurable';

__PACKAGE__->add_config(
  interval => {
    validator => sub { m/^\d+(?:\.\d+)?$/ },
    default => 1,
  },
);

sub new {
  my ($class, $args) = @_;

  # TODO super

  my $self = bless {
    config => {},
    output => undef,
    thread => undef,
    updated => 0,
  }, $class;

  return $self;
}

sub updated { shift->{updated} }

sub run {
  my ($self) = @_;

  croak 'Base module implementation';
}

sub output {
  my ($self) = @_;

  if ($self->{thread}) {
    if ($self->{thread}->is_joinable) {
      $self->{output} = $self->{thread}->join;
      $self->{updated} = time;
      $self->{thread} = undef;
    }
  } elsif (time - $self->updated >= $self->config('interval')) {
    $self->{thread} = threads->create(sub { return $self->run() });
  }

  return $self->{output};
}

1;
