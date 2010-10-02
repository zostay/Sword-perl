package Sword::XS;
use strict;
use warnings;

our $VERSION = '0.001';

require XSLoader;
XSLoader::load('Sword', $Sword::XS::VERSION);

1;
