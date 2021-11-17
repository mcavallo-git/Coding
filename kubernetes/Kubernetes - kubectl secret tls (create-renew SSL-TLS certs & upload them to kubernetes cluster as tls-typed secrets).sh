#!/bin/bash
# ------------------------------------------------------------

# cert.pem      ! Don't use cert by itself - causes HSTS issues since it's no longer attached to its cabundle !
# chain.pem
# fullchain.pem
# privkey.pem


# ------------------------------
### INSTALL PREREQS:
# ------------------------------

# Install certbot
apt-get -y update; apt-get -y install letsencrypt;


# ------------------------------
### CREATE/RENEW CERT:
# ------------------------------

# Create/renew wildcard SSL/TLS (HTTPS) certificate
if [ -z "${DN}" ]; then read -p "Enter domain name to create/renew SSL/TLS certificates for:  " -a DN -t 60 <'/dev/tty'; fi;
certbot certonly --manual --manual-public-ip-logging-ok --server "https://acme-v02.api.letsencrypt.org/directory" --preferred-challenges dns-01 -d "${DN}" -d "*.${DN}"; certbot certificates -d "${DN}";


# ------------------------------

# Copy certs to output dir
if [ -z "${DN}" ]; then read -p "Enter domain name to create/renew SSL/TLS certificates for:  " -a DN -t 60 <'/dev/tty'; fi;
OUTDIR="/mnt/c/ISO/Certificates_SSL/wildcard-${DN//./-}.$(date +'%Y%m%dT%H%M%S')";
mkdir -p "${OUTDIR}";
CERT="cert";      cp -rfv "$(realpath /etc/letsencrypt/live/${DN}/${CERT}.pem)" "${OUTDIR}/${CERT}.pem";
CERT="chain";     cp -rfv "$(realpath /etc/letsencrypt/live/${DN}/${CERT}.pem)" "${OUTDIR}/${CERT}.pem";
CERT="fullchain"; cp -rfv "$(realpath /etc/letsencrypt/live/${DN}/${CERT}.pem)" "${OUTDIR}/${CERT}.pem";
CERT="privkey";   cp -rfv "$(realpath /etc/letsencrypt/live/${DN}/${CERT}.pem)" "${OUTDIR}/${CERT}.pem";
ls -al "${OUTDIR}";

# Get expiration date of certificate
CERT_EXP_DATE="$(openssl x509 -in "${OUTDIR}/cert.pem" -text -noout | sed -rne 's/^\s*not\s*after\s*:\s*(.+)$/\1/pi' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)";
CERT_EXP_DATE_SHORTHAND="$(date --utc --date="${CERT_EXP_DATE}" +'%Y-%m-%dT%H:%M:%SZ';)";
CERT_EXP_DATE_FILENAME="$(date --utc --date="${CERT_EXP_DATE}" +'%Y-%m-%dT%H-%M-%SZ';)";


# Convert cert from PEM to PFX (PKCS12) format
openssl pkcs12 -export -out "${OUTDIR}/$(basename "${OUTDIR}";).pfx" -in "${OUTDIR}/fullchain.pem" -inkey "${OUTDIR}/privkey.pem";


# Show output dir
echo -e "Opening output directory \"${OUTDIR}\"...\n  (or \"C:\\ISO\\Certificates_SSL\\$(basename "${OUTDIR}";)\" in Windows)"; explorer.exe "C:\\ISO\\Certificates_SSL\\$(basename "${OUTDIR}";)";
# > 7-zip all certs together
#  > Zip the 7-zip
#   > Attach to password vault item "SSL Cert - *.${DN}"


# ------------------------------

# Apply updated certificate(s) to Kubernetes cluster
if [ -z "${DN}" ]; then read -p "Enter domain name to create/renew SSL/TLS certificates for:  " -a DN -t 60 <'/dev/tty'; fi;

# Delete & recreate the ssl/tls cert on Kubernetes cluster for namespace "default"
kubectl --namespace "default" delete secret tls "wildcard-${DN//./-}" --ignore-not-found;
kubectl --namespace "default" create secret tls "wildcard-${DN//./-}" --key="/etc/letsencrypt/live/${DN}/privkey.pem" --cert="/etc/letsencrypt/live/${DN}/fullchain.pem";


# ------------------------------

# DEBUG  -->  Verify/check the [ tls private-key ] & [ tls certificate ] secret values currently active on the Kubernetes cluster
KUBECTL_TLS_KEY=$(kubectl --namespace "default" get secret "wildcard-${DN//./-}" --output go-template="{{index .data \"tls.key\" | base64decode }}");  echo "KUBECTL_TLS_KEY=[${KUBECTL_TLS_KEY}]";
KUBECTL_TLS_CRT=$(kubectl --namespace "default" get secret "wildcard-${DN//./-}" --output go-template="{{index .data \"tls.crt\" | base64decode }}");  echo "KUBECTL_TLS_CRT=[${KUBECTL_TLS_KEY}]";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Use your TLS certificates for ingress - Azure Kubernetes Service | Microsoft Docs"  |  https://docs.microsoft.com/en-us/azure/aks/ingress-own-tls
#
#   help.hcltechsw.com  |  "Convert a PEM Certificate to PFX/P12 format"  |  https://help.hcltechsw.com/appscan/Standard/9.0.3/en-US/t_ConvertthepfxCertificatetopemFormat068.html
#
#   stackoverflow.com  |  "kubectl - How can I update a secret on Kubernetes when it is generated from a file? - Stack Overflow"  |  https://stackoverflow.com/a/45881324
#
# ------------------------------------------------------------