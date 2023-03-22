# NGINX (as a Windows Service)

***

## Installation Instructions

1. Create directory `C:\nginx` & copy the contents of this directory (from the git repo) into it

<br />

2. Configure `sites-enabled/subdomain.domain.tld.nginx` as needed for your application
  - If you rename `subdomain.domain.tld.nginx`, make sure to update `conf/nginx.conf` to contain the updated filename

<br />

3. Place your wildcard SSL (HTTPS) certificate in PEM format into directory `certs/wildcard.domain.tld_expires-yyyy-MM-ddTHH-mm-ssZ/pem-format` 
  - Rename `wildcard.domain.tld_expires-yyyy-MM-ddTHH-mm-ssZ` (in the `certs` directory) to match your current wildcard certificate's expiration date, then update `certs/nginx-update-certs.bat` to contain the same updated (timestamped) directory name
  - Run `certs/nginx-update-certs.bat` to create symbolic links to the latest wildcard certificates (for zero-downtime updates down the road)

<br />

4. Run (as admin) `service/Install_NGINX-Service.bat` to add NGINX as a Windows Service

***