#!/bin/bash

openssl pkcs7 -print_certs -in certificate.p7b -out certificate.cer;


# ------------------------------------------------------------
#
# Citation(s)
#
#   knowledge.digicert.com  |  "How to convert PKCS #7 (.p7b) to PEM certificate format using OpenSSL"  |  https://knowledge.digicert.com/solution/SO21448.html
#
# ------------------------------------------------------------