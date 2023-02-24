#!/usr/bin/perl
# Includes
use Net::Domain qw(hostname hostfqdn hostdomain);

# Test perl
print "Content-Type: text/html\n\n";
print ("<h1>Perl is working!</h1>");

# Get a hostname
my $host = hostname();
print "The host name is $host \n";