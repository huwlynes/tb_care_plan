
use strict;
use warnings;

use File::Basename;
use MIME::Base64;

my ($file, $dir, $ext) = fileparse($ARGV[0]);

open(my $fh, $ARGV[0]) or die "No such file $ARGV[0]\n";
while(my $line = <$fh> ){
    if ($line =~ /<link href="(.*)" rel="stylesheet"/) {
        open(my $css, "$dir$1") or die "Couldn't find css file $1\n";
        print "<style>\n";
        while(my $cssline = <$css> ){
            print $cssline;
        }
        print "</style>\n";
    }elsif($line =~ /<script type="text\/javascript" src="(.*)">/){
        open(my $js, "$dir$1") or die "Couldn't find js file $1\n";
        print "<script>\n";
        while(my $jsline = <$js> ){
            print $jsline;
        }
        print "</script>\n";
    }elsif($line =~ /<img src="(.*)" /){

        my $filename = "$dir$1";
        open my $fh, '<', $filename or die "error opening $filename: $!";
        my $data = do { local $/; <$fh> };

        my $encoded = encode_base64($data);
        print "<img src=\"data:image/gif;base64,\n$encoded\" />";
    }else{
        print $line;
    }
}
