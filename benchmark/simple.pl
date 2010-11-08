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
        foreach my $i(1 .. 100) {
            my $x = pv_add({ x => $i, y => $i });
            $x == ($i * 2) or die $x;
        };
    },
    'S::Args' => sub {
        foreach my $i(1 .. 100) {
            my $x = sa_add({ x => $i, y => $i });
            $x == ($i * 2) or die $x;
        }
    },
};
