requires 'perl', '5.010';

requires 'Carp';
requires 'DateTime';
requires 'IO::File';
requires 'Net::MPD';
requires 'Time::HiRes';

on test => sub {
  requires 'Test::More', '0.88';
};
