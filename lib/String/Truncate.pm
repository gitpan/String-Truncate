package String::Truncate;

use warnings;
use strict;

use base qw(Exporter);
our @EXPORT_OK = qw(elide trunc);

use Carp qw(croak);

=head1 NAME

String::Truncate - a module for when strings are too long to be displayed in...

=head1 VERSION

version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

This module handles the simple but common problem of long strings and finite
terminal width.  It can convert:

 "this is your brain" -> "this is your ..."
                      or "...is your brain"
                      or "this is... brain"

It's simple:

 use String::Truncate qw(elide);

 my $brain = "this is your brain";

 elide($brain, 16); # first option
 elide($brain, 16, { truncate => 'left' });   # second option
 elide($brain, 16, { truncate => 'middle' }); # third option

=head1 FUNCTIONS

=head2 C< elide($string, $length, \%arg) >

This function returns the string, if it is less than or equal to C<$length>
characters long.  If it is longer, it truncates the string and marks the
elision.

Valid arguments are:

 elide  - elide at left, right, or middle? (default: right)
 marker - how to mark the elision (default: ...)

=cut

sub elide {
  my ($string, $length, $arg) = @_;

  $arg ||= {};
  my $truncate = $arg->{truncate} || 'right';
  croak "invalid value for truncate argument: $truncate"
    unless grep { $_ eq $truncate } qw(left middle right);

  my $marker = defined $arg->{marker} ? $arg->{marker} : '...';
  croak "elision marker $marker is longer than allowed length $length!"
    if length($marker) > $length;

  # hey, this might be really easy:
  return $string if length($string) <= $length;
  
  # how much of the string should be left?
  my $keep = $length - length($marker);

  if ($truncate eq 'right') {
    return substr($string, 0, $keep) . $marker;
  } elsif ($truncate eq 'left') {
    return $marker . substr($string, -$keep, $keep);
  } else { # middle
    my ($keep_left, $keep_right) = (int($keep / 2)) x 2;
    $keep_left +=1 if ($keep_left + $keep_right) < $keep;
    return substr($string, 0, $keep_left)
         . $marker
         . substr($string, -$keep_right, $keep_right);
  }
}
  
=head2 C<< trunc($string, $length, \%arg) >>

This acts just like C<elide>, but assumes an empty marker, so it actually
truncates the string normally.

=cut

sub trunc {
  my ($string, $length, $arg) = @_;
  $arg ||= {};

  croak "marker may not be passed to trunc()" if exists $arg->{marker};
  $arg->{marker} = '';

  return elide($string, $length, $arg);
}

=head1 AUTHOR

Ricardo Signes, C<< <rjbs at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-string-truncate@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=String-Truncate>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2005 Ricardo Signes, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of String::Truncate
