#!/bin/bash
#
# Convert from a '.p7b' (pkcs#7) certificate to a '.pem' (PEM) certificate
#
# ------------------------------------------------------------

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