#!/bin/bash
# ------------------------------------------------------------
#
# .pfx --> .pem
#   Convert from [ PFX (pkcs12) certificate format ] to [ Privacy-Enhanced Mail (PEM) certificate format ]
#

if [[ 1 -eq 1 ]]; then
FULLPATH_PFX_CERT="/path/to/pfx/certificate.pfx";
read -p "Enter certificate password for file \"${FULLPATH_PFX_CERT}\" (or hit enter for no password):  " -s -a CERT_PASS -t 60 <'/dev/tty'; echo "";
openssl pkcs12 -in "${FULLPATH_PFX_CERT}" -password "pass:${CERT_PASS}" -clcerts -nokeys | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > "${FULLPATH_PFX_CERT}.crt.pem";
openssl pkcs12 -in "${FULLPATH_PFX_CERT}" -password "pass:${CERT_PASS}" -nocerts -nodes | sed -ne '/-BEGIN PRIVATE KEY-/,/-END PRIVATE KEY-/p' > "${FULLPATH_PFX_CERT}.key.pem";
openssl pkcs12 -in "${FULLPATH_PFX_CERT}" -password "pass:${CERT_PASS}" -cacerts -nokeys | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > "${FULLPATH_PFX_CERT}.chain.pem";
cat "${FULLPATH_PFX_CERT}.crt.pem" "${FULLPATH_PFX_CERT}.chain.pem" > "${FULLPATH_PFX_CERT}.fullchain.pem";
echo "Certificate output path:    ${FULLPATH_PFX_CERT}.crt.pem";
echo "Private key output path:    ${FULLPATH_PFX_CERT}.key.pem";
echo "CA Bundle output path:      ${FULLPATH_PFX_CERT}.chain.pem";
echo "Fullchain output path:      ${FULLPATH_PFX_CERT}.fullchain.pem";
fi;


# ------------------------------------------------------------
#
# .pem --> .pfx
#   Convert from [ Privacy-Enhanced Mail (PEM) certificate format ] to [ PFX (pkcs12) certificate format ]
#

if [[ 1 -eq 1 ]]; then
echo "";
echo "Calling [ openssl pkcs12 -export -in \"${FULLPATH_FULLCHAIN}\" -inkey \"${FULLPATH_PRIVKEY}\" -out \"${FULLPATH_OUTPUT_CERT}\" ]";
openssl pkcs12 -export -in "${FULLPATH_FULLCHAIN}" -inkey "${FULLPATH_PRIVKEY}" -out "${FULLPATH_OUTPUT_CERT}";
fi;


# ------------------------------------------------------------
#
# .p7b --> .pem
#   Convert from [ P7B (pkcs7) certificate format ] to [ Privacy-Enhanced Mail (PEM) certificate format ]
#

openssl pkcs7 -in certificate.p7b -print_certs | grep -iv 'subject' | grep -iv 'issuer' | sed -e '/^$/d' > certificate.pem;

# Optionally, add type of incoming certificate type via  [ -inform DER ]
openssl pkcs7 -in certificate.p7b -inform DER -print_certs | grep -iv 'subject' | grep -iv 'issuer' | sed -e '/^$/d' > certificate.pem;


# ------------------------------------------------------------
#
# Citation(s)
#
#   knowledge.digicert.com  |  "How to convert PKCS #7 (.p7b) to PEM certificate format using OpenSSL"  |  https://knowledge.digicert.com/solution/SO21448.html
#
#   serverfault.com  |  "Convert from P7B to PEM via OpenSSL - Server Fault"  |  https://serverfault.com/a/417286
#
# ------------------------------------------------------------