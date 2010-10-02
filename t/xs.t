no Moose;

use Test::More tests => 3;

use_ok('Sword::XS');

my $library = Sword::XS::get_library();
#diag explain $library;

my @modules = Sword::XS::list_modules($library);
#diag explain \@modules;

my %john316 = (
    KJV => "\nFor God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.\n",
    ESV => "\nFor  [] God so loved  [] the world,  [] that he gave his only Son, that whoever believes in him should not  [] perish but have eternal life.",
);

for my $name (keys %john316) {
    SKIP: {
        #skip "$name is not in your Sword library", 1
        #    unless grep /^\Q$name\E$/, @modules;

        my $module = Sword::XS::get_module($library, $name);
        #diag explain $module;

        my $text = Sword::XS::get_key_text($module, 'john 3:16');

        #diag $text;

        is($text, $john316{$name});
    }
}
