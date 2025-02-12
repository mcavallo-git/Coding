#!/bin/bash
# ------------------------------------------------------------
# Hotfix: If curl requests are failing to resolve due to server certificates not being trusted
# ------------------------------------------------------------

### Step 0) Show example of error message (to be fixed):
DOMAIN="raw.githubusercontent.com"; curl "${DOMAIN}";
#    curl: (60) SSL certificate problem: unable to get local issuer certificate
#    More details here: https://curl.se/docs/sslcerts.html
#    curl failed to verify the legitimacy of the server and therefore could not establish a secure connection to it. To learn more about this situation and how to fix it, please visit the web page mentioned above.

# ------------------------------

# Step 1) Get Server Certificate (CaCert) for target Domain
DOMAIN="raw.githubusercontent.com"; openssl s_client -connect ${DOMAIN}:443;

# ------------------------------

# Step 2) Create certificate file (to import from) and copy above certificate's contents into it (all content including & between "-----BEGIN CERTIFICATE-----" and "-----END CERTIFICATE-----")
DOMAIN="raw.githubusercontent.com"; CERT_PATH="/usr/local/share/ca-certificates/${DOMAIN//./_}.crt"; vi "${CERT_PATH}";

# ------------------------------

# Step 3) Import certificates (to import from recently created file into global certs file @ "/etc/ssl/certs/ca-certificates.crt")
update-ca-certificates;

# ------------------------------

# Step 4) Attempt to curl domain which was originally blocked
DOMAIN="raw.githubusercontent.com"; curl "${DOMAIN}";

# ------------------------------------------------------------