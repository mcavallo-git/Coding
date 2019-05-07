
# Creating Certificates via Certbot (Software) through LetsEncrypt (Free SSL/TLS Certificate Authority/Provider)

***
## NGINX - Creating a new NGINX host:
```
DN="example1.com"; NG="/etc/nginx/sites-available/${DN}.nginx"; echo "" > ${NG}; vi ${NG}; ln -sf ${NG} /etc/nginx/sites-enabled/${DN}; nginx -t && sleep 1 && service nginx start;
```


***
## Certbot - Create a new HTTPS  Cert covering One domain
##### For use through NGINX (web server), use the syntax:
```
certbot --nginx -d www.example1.com;

```

***
## Certbot - Create a new HTTPS Cert covering Multiple domains
#### To create a new HTTPS Certificate covering multiple Domains/Subdomains (all on the same certificate), just pass additional "-d" arguments into certbot, one for each (sub)domain:
```
certbot --nginx -d example1.com -d www.example1.com;
```


***
# WARNING
## You can only create ~15 new certificates per week, per device.
## This is to keep things legitimate as well as continue to keep them free.
## Use the argument "--dry-run" with certbot until you're for-sure ready to perform your certificate verification


- Congratulations! Your certificate and chain have been saved at:
/etc/letsencrypt/live/example1.com/fullchain.pem

Your key file has been saved at:
/etc/letsencrypt/live/example1.com/privkey.pem


***
NOTE: The 'live' directory points to the most up-to-date cert held in the '/etc/letsencrypt/archive' directory, by default (symbolic link)
```/etc/letsencrypt/live/example1.com/...```
...holds symbolic links to...
```/etc/letsencrypt/archive/example1.com/...```
...per-certificate

***
Static Links to HTTPS Certificates (per FQDN) should therefore always be referenced via the directory:
```/etc/letsencrypt/live/example1.com```
...which contains the following four files, per certificate:
**Certificate**: ```cert.pem```   -->   ```/etc/letsencrypt/live/example1.com/cert.pem```
**Private Key**: ```privkey.pem```   -->   ```/etc/letsencrypt/live/example1.com/privkey.pem```
**Certificate Chain (Trust)**: ```chain.pem```   -->   ```/etc/letsencrypt/live/example1.com/chain.pem```
**Certificate Full-Chain**: ```fullchain.pem```   -->   ```/etc/letsencrypt/live/example1.com/fullchain.pem```


***
## Check Global (Certbot) certificate status for all local certificates
```
certbot certificates
```


*** 
## Revoking/Deleting LetsEncrypt Certificates via Certbot
If, for whatever reason, you wish to remove a given domain's certificate, Certbot has you covered with the below approach:
```

FQDN="example1.com";

certbot revoke --cert-path "/etc/letsencrypt/live/${FQDN}/fullchain.pem"; # Make sure to revoke FIRST, so that 

certbot delete --cert-name "${FQDN}"; # Allow certbot to remove any files no longer needed for the domain being removed

find "/etc/letsencrypt/" -name "*${FQDN}*"; # Double-Check to make sure the domain is fully removed, otherwise remove the related items

unlink "/etc/nginx/sites-enabled/${FQDN}";

```