#!perl -w
use strict;
use Benchmark qw(:all);

use Params::Validate qw(:all);
use Smart::Args;

foreach my $mod (qw(Params::Validate Smart::Args)) {
    print $mod, "/", $mod->VERSION, "\n";
}

sub pv_add {
    my %args = validate( @_ => { x => 1, y => 1 } );
    return $args{x} + $args{y};
}

sub sa_add {
    args my $x, my $y;
    return $x + $y;
}

print "without type constraints\n";
cmpthese -1, {
    'P::Validate' => sub {
        my $x = pv_add({ x => 10, y => 10 });
    },
    'S::Args' => sub {
        my $x = sa_add({ x => 10, y => 10 });
    },
};
