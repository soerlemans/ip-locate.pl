# ip-locate.pl
Lazy Perl script (only uses builtin modules) for querying ip-api.com to query a list of IP's for location and such.
Works for querying both IPv4 and IPv6.

## Usage
```
#~ ./ip-locate.pl 1.1.1.1 8.8.8.8

{"google_maps_link":"https://www.google.com/maps/search/?api=1&query=-27.4766,153.0166","status":"success","as":"AS13335 Cloudflare, Inc.","query":"1.1.1.1","timezone":"Australia/Brisbane","country":"Australia","regionName":"Queensland","city":"South Brisbane","zip":"4101","org":"APNIC and Cloudflare DNS Resolver project","isp":"Cloudflare, Inc","region":"QLD","lon":153.0166,"countryCode":"AU","lat":-27.4766}
{"timezone":"America/New_York","query":"8.8.8.8","as":"AS15169 Google LLC","google_maps_link":"https://www.google.com/maps/search/?api=1&query=39.03,-77.5","status":"success","countryCode":"US","lat":39.03,"region":"VA","org":"Google Public DNS","isp":"Google LLC","zip":"20149","lon":-77.5,"city":"Ashburn","country":"United States","regionName":"Virginia"}


#~ cat ips.txt | ./ip-locate.pl

{"google_maps_link":"https://www.google.com/maps/search/?api=1&query=-27.4766,153.0166","status":"success","as":"AS13335 Cloudflare, Inc.","query":"1.1.1.1","timezone":"Australia/Brisbane","country":"Australia","regionName":"Queensland","city":"South Brisbane","zip":"4101","org":"APNIC and Cloudflare DNS Resolver project","isp":"Cloudflare, Inc","region":"QLD","lon":153.0166,"countryCode":"AU","lat":-27.4766}
{"timezone":"America/New_York","query":"8.8.8.8","as":"AS15169 Google LLC","google_maps_link":"https://www.google.com/maps/search/?api=1&query=39.03,-77.5","status":"success","countryCode":"US","lat":39.03,"region":"VA","org":"Google Public DNS","isp":"Google LLC","zip":"20149","lon":-77.5,"city":"Ashburn","country":"United States","regionName":"Virginia"}
```

Expects IP's either from STDIN or as command line arguments.
Will output results as line delimited JSON for every entry.

Note: I am not liable for how this script is used.
Please use responsibly.
