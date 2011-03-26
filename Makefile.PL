
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'a module for when strings are too long to be displayed in...',
  'AUTHOR' => 'Ricardo Signes <rjbs@cpan.org>',
  'BUILD_REQUIRES' => {
    'Test::More' => '0.96'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'String-Truncate',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'String::Truncate',
  'PREREQ_PM' => {
    'Carp' => '0',
    'Sub::Exporter' => '0.953',
    'Sub::Exporter::Util' => '0',
    'Sub::Install' => '0.03'
  },
  'VERSION' => '1.100600',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



