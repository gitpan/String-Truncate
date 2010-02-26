
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'String::Truncate',
                       'DISTNAME' => 'String-Truncate',
                       'AUTHOR' => 'Ricardo Signes <rjbs@cpan.org>',
                       'ABSTRACT' => 'a module for when strings are too long to be displayed in...',
                       'EXE_FILES' => [],
                       'VERSION' => '1.100570',
                       'LICENSE' => 'perl',
                       'PREREQ_PM' => {
                                        'Test::More' => '0.88',
                                        'Sub::Exporter::Util' => 0,
                                        'Sub::Install' => '0.03',
                                        'ExtUtils::MakeMaker' => '6.11',
                                        'Sub::Exporter' => '0.953',
                                        'Carp' => 0
                                      }
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



