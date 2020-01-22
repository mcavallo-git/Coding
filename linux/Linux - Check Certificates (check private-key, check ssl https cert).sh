# Check a private key
openssl rsa -in privateKey.key -check

# Check a certificate
openssl x509 -in certificate.crt -text -noout

# Check a PKCS#12 file (.pfx or .p12)
openssl pkcs12 -info -in keyStore.p12


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.sslshopper.com  |  "The Most Common OpenSSL Commands"  |  https://www.sslshopper.com/article-most-common-openssl-commands.html
#
# ------------------------------------------------------------