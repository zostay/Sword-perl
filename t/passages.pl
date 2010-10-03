package main;

our (%tests, $total_tests, $subtotal_tests);

%tests = (
    KJV => {
        'John 3:16' => "\nFor God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.\n",
    },
    ESV => {
        'John 3:16' => "\nFor  [] God so loved  [] the world,  [] that he gave his only Son, that whoever believes in him should not  [] perish but have eternal life.",
    },
);

$total_tests = 0;
for my $module (keys %tests) {
    $subtotal_tests{$module} = 0;

    for my $key (keys %{ $tests{$module} }) {
        $total_tests++;
        $subtotal_tests{$module}++;
    }
}

1;
