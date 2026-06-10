use strict;
use warnings;
use ExtUtils::MakeMaker;
use File::Find;

# Ship modules AND the resources tree (templates/settings/locale/migrations) under
# lib/. EUMM only auto-detects .pm/.pod, so build the PM map ourselves so resources
# install to site_perl alongside the code (Mojolicious-style).
my %pm;
find(sub {
  return unless -f;
  return if /\.(bak|orig|rej|swp)$/;
  my $path = $File::Find::name;
  (my $rel = $path) =~ s{^lib/}{};
  $pm{$path} = "\$(INST_LIB)/$rel";
}, 'lib');

WriteMakefile(
  NAME             => 'Samizdat::Plugin::Skeleton',
  VERSION          => '0.01',
  ABSTRACT         => 'A minimal Samizdat plugin (template)',
  AUTHOR           => 'Hans Svensson <hans@alipang.se>',
  LICENSE          => 'artistic_2',
  MIN_PERL_VERSION => '5.036',
  PM               => \%pm,
  # Declare this plugin's real CPAN deps here (cpanm --installdeps . in CI reads them):
  PREREQ_PM        => {
    'Mojolicious' => '9.0',
  },
  TEST_REQUIRES    => { 'Test::More' => 0 },
  META_MERGE       => {
    'meta-spec' => { version => 2 },
    # core Samizdat provides the settings resolver, pg helper, Cache, etc.
    prereqs     => { runtime => { requires => { 'Samizdat' => 0 } } },
    no_index    => { directory => ['lib/Samizdat/resources'] },
  },
  dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
  clean => { FILES => 'Samizdat-Plugin-Skeleton-*' },
);
