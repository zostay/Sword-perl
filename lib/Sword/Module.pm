package Sword::Module;
use strict;
use warnings;

our $VERSION = '0.001';

require XSLoader;
XSLoader::load('Sword', $Sword::Module::VERSION);

1;
