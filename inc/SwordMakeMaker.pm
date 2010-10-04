package inc::SwordMakeMaker;
use Moose;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

override _build_WriteMakefile_args => sub {
    my ($self) = @_;
    
    return +{
        %{ super() },
        CC       => 'g++',
        INC      => '-I/home/sterling/local/include/sword',
        LIBS     => [ '-L/home/sterling/local/lib -lsword' ],
        XSOPT    => '-C++ -noprototypes',
    };
};

__PACKAGE__->meta->make_immutable;

