no Moose;

require 't/passages.pl';
use Test::More;

plan tests => 1 + $main::total_tests;

use_ok('Sword::XS');

my $library = Sword::XS::get_library();
#diag explain $library;

my @modules = Sword::XS::list_modules($library);
#diag explain \@modules;

for my $name (keys %main::tests) {
    SKIP: {
        skip "$name is not in your Sword library", $subtotal_tests{$name}
            unless grep { $_ eq $name } @modules;

        my $module = Sword::XS::get_module($library, $name);
        #diag explain $module;

        for my $key (keys %{ $main::tests{$name} }) {
            my $text = Sword::XS::get_key_text($module, $key);

            #diag $text;

            is($text, $main::tests{$name}{$key});
        }
    }
}
