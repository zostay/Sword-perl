package Sword::Manager;
use strict;
use warnings;

our $VERSION = '0.001';

require XSLoader;
XSLoader::load('Sword', $Sword::Manager::VERSION);

1;

