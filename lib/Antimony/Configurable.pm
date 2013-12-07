package Antimony::Configurable;

use strict;
use warnings;

use Carp 'croak';

our %CONF = ();

sub new {
  my ($class, $args) = @_;

  my $self = bless {
    config => {},
  }, $class;

  return $self;
}

# TODO make these inheritable

sub add_config {
  my ($class, %items) = @_;

  foreach (keys %items) {
    my $item = $items{$_};

    croak "Config key $_ does not have a default" unless exists $item->{default};

    $CONF{$class}{$_} = $item;
  }
}

sub config {
  my ($self, $key) = @_;

  my $class = ref $self;

  croak "No such configuration key: $class::$key" unless $CONF{$class}{$key};

  return $self->{config}{$key} || $CONF{$class}{$key}{default};
}

sub set_config {
  my ($self, $key, $value) = @_;

  my $class = ref $self;

  croak "No such configuration key: $class::$key" unless $CONF{$class}{$key};

  if (my $validator = $CONF{$class}{$key}{validator}) {
    croak "Invalid value for $key" unless $validator->($value);
  }

  $self->{config}{$key} = $value;
}

1;
