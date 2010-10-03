package Sword::Module;
use Moose;

use Sword::XS;

=head1 NAME

Sword::Module - provides access to a Sword module

=head1 SYNOPSIS

  use Sword;

  my $library = Sword->new;

  if (grep { $_ eq 'ESV' } $library->modules) {
      my $esv = $library->module('ESV');

      my $verse = $esv->lookup_text('John 3:16');
      print "John 3:16: $verse\n";
  }

=head1 DESCRIPTION

Access a Sword module.

=head1 ATTRIBUTES

=head2 library

The L<Sword> object this module is associated with.

=cut

has library => (
    is        => 'ro',
    isa       => 'Sword',
    required  => 1,
);

=head2 name

The name of the module in the library configuration.

=cut

has name => (
    is        => 'ro',
    isa       => 'Str',
    required  => 1,
);

=head2 module

This is the internal C<SWModule> pointer used to talk to the Sword Engine API.

=cut

has module => (
    is        => 'ro',
    required  => 1,
);

=head1 METHODS

=head2 new

Do not use. See L<Sword/module> instead.

=head2 lookup_text

  my $text = $module->lookup_text($key);

Lookup a text using a key.

=cut

sub lookup_text {
    my ($self, $key) = @_;

    return Sword::XS::get_key_text($self->module, $key);
}

__PACKAGE__->meta->make_immutable;

1;

