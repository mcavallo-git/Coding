# Installation Instructions - NGINX (as a Windows Service)
  1. Create directory `C:\nginx` & copy the contents of this directory (from the git repo) into it
  2. Configure `sites-enabled/subdomain.domain.tld.nginx` as needed for your application
  3. Place wildcard certificate into `certs/wildcard.domain.tld_expires-yyyy-MM-ddTHH-mm-ssZ/pem-format/.` and rename `wildcard.domain.tld_expires-yyyy-MM-ddTHH-mm-ssZ` to match your current wildcard certificate's expiration date
  4. Update `certs/nginx-update-certs.bat` to contain the latest certificate date (from `step 3`) then run it to create symbolic certificate links (for zero-downtime updates down the road)
  5. Run (as admin) `service/Install_NGINX-Service.bat` to add NGINX as a Windows Service