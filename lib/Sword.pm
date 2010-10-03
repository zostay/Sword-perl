package Sword;
use Moose;

use Sword::Module;
use Sword::XS;

=head1 NAME

Sword - provides an interface to the Sword Open Source Bible Software API

=head1 SYNOPSIS

  use Sword;

  my $library = Sword->new;

  if (grep { $_ eq 'ESV' } $library->modules) {
      my $esv = $library->module('ESV');

      my $verse = $esv->lookup_text('John 3:16');
      print "John 3:16: $verse\n";
  }

=head1 DESCRIPTION

B<EXPERIMENTAL>. The goal is to reproduce the Sword Engine API faithfully, but not rigidly, in Perl. This is really just the first foray into that direction. It simply provides just enough to do what's shown in the L</SYNOPSIS>, but future versions should do so much more and to get there, things will probably need to change a lot here.

=head1 ATTRIBUTES

=head2 library

This is the internal C<SWMgr> pointer used to talk to the Sword Engine API.

=cut

has library => (
    is         => 'ro',
    required   => 1,
    lazy_build => 1,
);

sub _build_library { Sword::XS::get_library() }

=head1 METHODS

=head2 new

  my $sword = Sword->new;

Returns a L<Sword> object that can be used to access the modules in your library.

=head2 modules

  my @names = $sword->modules;

Returns a list of module names.

=cut

sub modules { 
    my $self = shift;
    return Sword::XS::list_modules($self->library);
}

=head2 module

  my Sword::Module $module = $sword->module($name);

Returns a L<Sword::Module> object that can be used to refer to data in particular textual source.

=cut

sub module { 
    my ($self, $name) = @_;
    return Sword::Module->new(
        library => $self, 
        name    => $name,
    );
}

=head1 SEE ALSO

Sword Project: L<http://www.crosswire.org/sword/index.jsp>

=cut

__PACKAGE__->meta->make_immutable;

1;
