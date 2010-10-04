package inc::SwordMakeMaker;
use Moose;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

override _build_WriteMakefile_args => sub {
    my ($self) = @_;
    
    return +{
        %{ super() },
        C        => [ 'lib/Sword/XS.c' ],
        CC       => 'g++',
        INC      => '-I/home/sterling/local/include/sword',
        LDFROM   => 'XS.o',
        LIBS     => [ '-L/home/sterling/local/lib -lsword' ],
        OBJECT   => 'lib/Sword/XS.o',
        XS       => { 'lib/Sword/XS.xs' => 'lib/Sword/XS.c' },
        XSOPT    => '-C++ -noprototypes',
    };
};

__PACKAGE__->meta->make_immutable;

