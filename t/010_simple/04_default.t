use strict;
use warnings;
use Smart::Args;
use Test::More;
use Test::Exception;

is foo(), 99;
done_testing;
exit;

sub foo {
    args my $p => { isa => 'Int', default => 99 };
    return $p;
}
