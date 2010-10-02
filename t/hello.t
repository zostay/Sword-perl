no Moose;

use Test::More tests => 1;

use_ok('Sword::XS');
Sword::XS::hello;

diag explain Sword::XS::kjv('john 3:16');
