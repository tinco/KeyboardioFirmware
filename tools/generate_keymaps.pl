use warnings;
use strict;

my @data = <STDIN>;

use Data::Dumper;

my $name = 'Unnamed';
my @map;


read_file();
printmap();

sub read_file {
for my $line (@data) {
    chomp($line);
    if ($line =~ /^#NAME: (.*)/i) {
        $name = $1;
    }
    if ($line =~ /^#/) {
        next;
    }

    my @keys = split(/\s+/, $line);
    push @map, [ map { 'Key_' . lookup($_) . '' } @keys];
}
}

sub write_file {
print "#define KEYMAP_$name { /* Generated keymap for $name */ ";
for my $line (@map) {
    print "\t{" . $line . "},\\\n";
}
print "},\n";
}

sub lookup {

    my %table = (
        '{'  => 'LCurlyBracket',
        '}'  => 'RCurlyBracket',
        '['  => 'LSquareBracket',
        ']'  => 'RSquareBracket',
        '|'  => 'Pipe',
        '\\' => 'Backslash',

        ';' => 'Semicolon',
        ',' => 'Comma',
        '.' => 'Period',
        '/' => 'Slash',
        "'" => 'Quote',
        '`' => 'Backtick',
        '-' => 'Minus',
        '=' => 'Equals');

    my $x = shift;
    return $x unless defined $table{$x};
    return $table{$x};
}



sub printmap {

    print "Key getKeyForMap(byte row, byte col) {\n    switch(row) {\n";
for my $i (0..4) {
print "        case $i:\n            switch(col) {\n";
for my $j (0..13) {
    next unless defined $map[$i][$j];
print "                case $j:\n                    return ".$map[$i][$j].";\n";
            
}

print "            }\n";


}


print "    }\n}\n";
}

__DATA__

        case 0:
            switch (col) {
                case 0:
                case 1:
                case 2:

            }
        case 1:
        case 2:
        case 3:
        case 4:
    }
        


}
