no Moose;

require 't/passages.pl';
use Test::More;

plan tests => 1 + $main::total_tests;

use_ok('Sword');

my $library = Sword->new;
#diag explain $library;

my @modules = $library->modules;
#diag explain \@modules;

for my $name (keys %main::tests) {
    SKIP: {
        skip "$name is not in your Sword library", $subtotal_tests{$name}
            unless grep { $_ eq $name } @modules;

        my $module = $library->module($name);
        #diag explain $module;

        for my $key (keys %{ $main::tests{$name} }) {
            my $text = $module->lookup_text($key);

            #diag $text;

            is($text, $main::tests{$name}{$key});
        }
    }
}
