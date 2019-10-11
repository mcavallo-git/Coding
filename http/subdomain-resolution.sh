#
# The website "https://api.hackertarget.com/hostsearch/?q=HOSTNAME.TLD" runs a web-based
# service of the Linux tool "amass" ( found @ https://github.com/OWASP/Amass ) which
# determines all subdomains for a given domain through exhaustive search methods
#

DOMAIN="getac.com" && curl "https://api.hackertarget.com/hostsearch/?q=${DOMAIN}";
