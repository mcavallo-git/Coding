#!/bin/bash
exit 0;
# ------------------------------------------------------------
#
# Certbot Certificate Creation & Renewal
#  |
#  |--> Certbot === runtime-package for performing Lets-Encrypt HTTPS/SSL certificate creation/renewal/etc. on Linux
#
# ------------------------------------------------------------
#
# Install Certbot  (Lets-Encrypt HTTPS/SSL certificate management tool for Linux)
#  |
#  |--> Refer to Certbot Documentation @:  https://certbot.eff.org/all-instructions
#


# Install just certbot (not certbot+nginx)
apt-get --yes update;
apt-get --yes install "letsencrypt";


if [[ 0 -eq 1 ]]; then # Install Certbot + NGINX

# To Install Certbot on Debian-based Linux Distros (e.g. Debian, Ubuntu) EXCLUDING Raspbian
add-apt-repository --yes --update "ppa:certbot/certbot";
apt-get --yes install "python-certbot-nginx";

# To Install Certbot on Fedora-based Linux Distros (e.g. Oracle Linux, Red Hat Enterprise Linux, or CentOS)
wget "https://dl.eff.org/certbot-auto" && chmod 755 certbot-auto;

# To Install Certbot on Raspbian (e.g. Raspberry-Pi 3 / Raspberry-Pi 4)
sed "$ a\deb http://ftp.debian.org/debian jessie-backports main" -i "/etc/apt/sources.list";
apt-get --yes update;
apt-get --yes install "certbot" --target-release "jessie-backports" --force-yes;
apt-get --yes install "python-certbot-nginx" --target-release "jessie-backports" --force-yes;

fi;


# ------------------------------------------------------------
#
# CHECK SSL CERTIFICATE(S):
#

certbot certificates;


# ------------------------------------------------------------
#
# WILDCARD  -  CREATE/RENEW SSL CERTIFICATE(S)
#  |
#  |--> Same command required for both (as-of June-2020) for wildcard certs through Let's Encrypt (as no simplified/all-in-one certbot renew command exists for LE cert-renewal):
#

DN="example.com"; certbot certonly --manual --manual-public-ip-logging-ok --server https://acme-v02.api.letsencrypt.org/directory --preferred-challenges dns-01 -d "${DN}" -d "*.${DN}"; certbot certificates -d "${DN}"; test -x "/usr/local/sbin/reload_nginx" && /usr/local/sbin/reload_nginx;


# ------------------------------------------------------------
#
# NON-WILDCARD  -  CREATE SSL CERTIFICATE(S)
#

#
# NGINX-Host based certificate (linking to service preferred for simplified verification of domain-ownership)
#	 |
#  |-->  uses arg:  --webroot
#	 |
#	 |-->  Note: didnt spend the time to find where webroot is for cpanel
#
DN="example.com"; WEBROOT="/var/www/html/${DN}"; certbot --webroot -w "${WEBROOT}" -d "${DN}" -d "www.${DN}";


#
# Standalone Certificate Creation (requires manual verification of domain-ownership by creating TXT records under "_acme-challenge.DOMAIN.TLD" with values that certbot gives you)
#	 |
#  |-->  uses args:  certonly --standalone
#	 |
#	 |-->  Note: AVOID THIS METHOD WHENEVER POSSIBLE (automating renewal becomes an issue if you use this method)
#	 |-->  Note: Must stop Apache, performed actions, then start Apache, again
#
DN="example.com"; WEBHOST_SVC="httpd"; service ${WEBHOST_SVC} stop; certbot certonly --standalone -d "${DN}" -d "www.${DN}"; service ${WEBHOST_SVC} start;


# ------------------------------------------------------------
#
# RENEW SSL CERTIFICATE(S) - NON-WILDCARD
#

#
# Dry-Run Renewal
#  |
#  |--> Note:   Debugging only - performs all renewal steps leading up-to the actual renewal
#               of the cert(s) on the server, but doesn't actually attempt to renew them
#
certbot renew --nginx --dry-run --deploy-hook "/usr/local/sbin/reload_nginx";


#
# Force certificate renewal-attempt
#  |
#  |--> Note:  Let's Encrypt certs, by default, wait until 30-days-remain on certs good for 90-days before marking them as needing renewal
#  |--> Note:  Let's Encrypt only lets you renew 5 times per week, per cert
#
certbot renew --noninteractive --force-renewal --dry-run --deploy-hook "/usr/local/sbin/reload_nginx";

certbot renew --force-renewal --dry-run;

ln -sf "/usr/local/sbin/reload_nginx" "/etc/letsencrypt/renewal-hooks/deploy/reload_nginx";


# ------------------------------------------------------------
#
# REVOKING/DELETING SSL CERTIFICATE(S):
#

DN="example1.com";

certbot revoke --cert-path "/etc/letsencrypt/live/${DN}/fullchain.pem"; # Make sure to revoke FIRST (send command to Let's Encrypt's servers to mark/tag the certificate as invalid on their end)

certbot delete --cert-name "${DN}"; # Allow certbot to remove any files no longer needed for the domain being removed

find "/etc/letsencrypt/" -name "*${DN}*"; # Double-Check to make sure the domain is fully removed, otherwise remove the related items

# unlink "/etc/nginx/sites-enabled/${DN}"; # Remove any dangling sym-links left over from revoked certificate


# ------------------------------------------------------------
#
#
# Note: the directory "/etc/letsencrypt/live" (default) points to the most up-to-date cert held in the "/etc/letsencrypt/archive" (default) directory / sym-link-to-directory
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   certbot.eff.org  |  "Certbot - All Instructions"  |  https://certbot.eff.org/all-instructions
#
#   dev.to  |  "Let's Encrypt: Renew Wildcard Certificate With Certbot - DEV"  |  https://dev.to/nabbisen/let-s-encrypt-renew-wildcard-certificate-manually-with-certbot-1jp
#
#   guides.wp-bullet.com  |  "Let’s Encrypt Wildcard SSL nginx for WordPress Ubuntu 18.04"  |  https://guides.wp-bullet.com/lets-encrypt-wildcard-ssl-nginx-for-wordpress-ubuntu-18-04/
#
#   medium.com  |  "How to obtain a wildcard ssl certificate from Let’s Encrypt and setup Nginx to use wildcard subdomain"  |  https://medium.com/@utkarsh_verma/how-to-obtain-a-wildcard-ssl-certificate-from-lets-encrypt-and-setup-nginx-to-use-wildcard-cfb050c8b33f
#
#   packages.debian.org  |  "Package: dpkg-dev (1.19.7) - Debian package development tools"  |  https://packages.debian.org/sid/dpkg-dev
#
#   serverspace.us  |  "How to Get Let's Encrypt SSL on Ubuntu 20.04 - Serverspace"  |  https://serverspace.us/support/help/how-to-get-lets-encrypt-ssl-on-ubuntu/
#
# ------------------------------------------------------------