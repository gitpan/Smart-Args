#!perl-w
use strict;
use Test::More;
use Test::Exception;
use Smart::Args;
use Mouse::Util::TypeConstraints;

subtype 'MyHashRef', as 'HashRef';

coerce 'MyHashRef',
    from 'ArrayRef', via {
        return +{ @{$_} };
    },
;

sub foo {
    args my $h => 'MyHashRef';
    return $h;
}

lives_and {
    is_deeply foo( h => { foo => 42 } ), { foo => 42 };
    is_deeply foo( h => [ foo => 42 ] ), { foo => 42 };
};

throws_ok {
    foo(h => 42);
} qr/Validation failed for 'MyHashRef' with value 42/;

done_testing;

