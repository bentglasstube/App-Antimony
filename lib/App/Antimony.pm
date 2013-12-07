package App::Antimony;

use 5.010;

use strict;
use warnings;

use base 'Antimony::Configurable';

use threads;
use threads::shared;

use Time::HiRes 'sleep';

our $VERSION = '0.01';

__PACKAGE__->add_config(
  interval => {
    validator => sub { m/^\d*[1-9]$/ },
    default => 0.1,
  },
);

sub new {
  my ($class, $args) = @_;

  # TODO super

  my $self = bless {
    config => {},
    publisher => undef,
    renderer => undef,
    modules => [],
  }, $class;

  # TODO parse config

  # TODO dummy config
  use Antimony::Renderer::Text;
  use Antimony::Publisher::StdOut;

  $self->{renderer} = Antimony::Renderer::Text->new();
  $self->{publisher} = Antimony::Publisher::StdOut->new();

  $self->add_module('Antimony::Module::File');
  $self->add_module('Antimony::Module::MPD');
  $self->add_module('Antimony::Module::Clock');

  return $self;
}

sub run {
  my ($self) = @_;

  my $interval = $self->config('interval');

  while (1) {
    my @items = grep { defined $_ } map $_->output, $self->modules;
    my $output = $self->renderer->render(@items);
    $self->publisher->publish($output);
    sleep $interval;
  }
}

sub add_module {
  my ($self, $class, @args) = @_;

  no strict 'refs';

  eval "use $class;";

  my $module = $class->new(@args);
  $module->output;  # starts the thread to get output
  push @{$self->{modules}}, $module;
}

sub renderer { shift->{renderer} }
sub publisher { shift->{publisher} }
sub modules { @{ shift->{modules} } }

1;

__END__

=encoding utf-8

=head1 NAME

App::Antimony - Modular threaded status bar

=head1 SYNOPSIS

  use App::Antimony;

  my $sb = new App::Antimony;
  $sb->run;

=head1 DESCRIPTION

App::Antimony is a modular, threaded status bar plugin.  It takes a number of
configurable plugins to output text suitable for a status bar such as is used
with dwm.

=head1 AUTHOR

Alan Berndt E<lt>alan@eatabrick.orgE<gt>

=head1 COPYRIGHT

Copyright 2013- Alan Berndt

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
