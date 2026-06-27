#!/usr/bin/env perl

use strict;
use warnings;

# Builtin PERL.
use HTTP::Tiny;
use JSON::PP;
use Socket qw(inet_pton AF_INET AF_INET6);

sub validate_ip {
    my ($new_ip) = @_;

    if ( inet_pton( AF_INET, $new_ip ) || inet_pton( AF_INET6, $new_ip ) ) {
        return 1;
    }

    print( STDERR "Error: Not a valid IP $new_ip.\n" );
    return 0;
}

sub read_stdin {
    my ($ips_ref) = @_;

    while ( my $line = <STDIN> ) {
        chomp($line);                   # Remove trailing newline.
        $line =~ s/(^\s+)|(\s+$)//g;    # Trim leading/trailing whitespace

        die "Empty IP input!\n" if $line eq '';
        if ( validate_ip($line) ) {
            push( @{$ips_ref}, $line );    # Push to @ips if valid IP.
        }
    }

    return 0;
}

my @ips;

if (@ARGV) {
    @ips = @ARGV;
}
elsif ( -t STDOUT ) {

    # Interactive usage.
    print( STDERR
"No arguments provided. Reading IPs from STDIN (Press Ctrl+D when done)...\n"
    ) if -t STDIN;

    read_stdin( \@ips );
}
else {
    # We are piping to another program dont output anything unnecessary.
    read_stdin( \@ips );
}

my $http        = HTTP::Tiny->new;
my $json_engine = JSON::PP->new;

# Go through ips.
foreach my $ip (@ips) {
    my $QUERY = "http://ip-api.com/json/$ip";

    my $response = $http->request( 'GET', $QUERY );
    unless ( $response->{success} ) {
        die "Failed!\n";
    }

    my $data = $json_engine->decode( $response->{content} );

    my $longitude = $data->{"lon"};
    my $latitude  = $data->{"lat"};

    $data->{"google_maps_link"} =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    my $result = $json_engine->encode($data);
    print("$result\n");
}
