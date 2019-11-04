#!/bin/bash


# Update package-repos & install sslscan:
apt update -y;
apt install -y sslscan;


# Use sslscan to scan a hostname & test its current cipher configuration

sslscan google.com
                   _
           ___ ___| |___  ___ __ _ _ __
          / __/ __| / __|/ __/ _  |  _ \
          \__ \__ \ \__ \ (_| (_| | | | |
          |___/___/_|___/\___\__,_|_| |_|

                  Version 1.8.2
             http://www.titania.co.uk
        Copyright Ian Ventura-Whiting 2009
ERROR: Could not create CTX object.

Testing SSL server google.com on port 443

  Supported Server Cipher(s):
    Failed    TLSv1  256 bits  ECDHE-RSA-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  ECDHE-ECDSA-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  ECDHE-RSA-AES256-SHA384
    Failed    TLSv1  256 bits  ECDHE-ECDSA-AES256-SHA384
    Accepted  TLSv1  256 bits  ECDHE-RSA-AES256-SHA
    Rejected  TLSv1  256 bits  ECDHE-ECDSA-AES256-SHA
    Failed    TLSv1  256 bits  SRP-DSS-AES-256-CBC-SHA
    Failed    TLSv1  256 bits  SRP-RSA-AES-256-CBC-SHA
    Failed    TLSv1  256 bits  SRP-AES-256-CBC-SHA
    Failed    TLSv1  256 bits  DH-DSS-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  DHE-DSS-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  DH-RSA-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  DHE-RSA-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  DHE-RSA-AES256-SHA256
    Failed    TLSv1  256 bits  DHE-DSS-AES256-SHA256
    Failed    TLSv1  256 bits  DH-RSA-AES256-SHA256
    Failed    TLSv1  256 bits  DH-DSS-AES256-SHA256
    Rejected  TLSv1  256 bits  DHE-RSA-AES256-SHA
    Rejected  TLSv1  256 bits  DHE-DSS-AES256-SHA
    Rejected  TLSv1  256 bits  DH-RSA-AES256-SHA
    Rejected  TLSv1  256 bits  DH-DSS-AES256-SHA
    Rejected  TLSv1  256 bits  DHE-RSA-CAMELLIA256-SHA
    Rejected  TLSv1  256 bits  DHE-DSS-CAMELLIA256-SHA
    Rejected  TLSv1  256 bits  DH-RSA-CAMELLIA256-SHA
    Rejected  TLSv1  256 bits  DH-DSS-CAMELLIA256-SHA
    Rejected  TLSv1  256 bits  AECDH-AES256-SHA
    Failed    TLSv1  256 bits  ADH-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  ADH-AES256-SHA256
    Rejected  TLSv1  256 bits  ADH-AES256-SHA
    Rejected  TLSv1  256 bits  ADH-CAMELLIA256-SHA
    Failed    TLSv1  256 bits  ECDH-RSA-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  ECDH-ECDSA-AES256-GCM-SHA384
    Failed    TLSv1  256 bits  ECDH-RSA-AES256-SHA384
    Failed    TLSv1  256 bits  ECDH-ECDSA-AES256-SHA384
    Rejected  TLSv1  256 bits  ECDH-RSA-AES256-SHA
    Rejected  TLSv1  256 bits  ECDH-ECDSA-AES256-SHA
    Failed    TLSv1  256 bits  AES256-GCM-SHA384
    Failed    TLSv1  256 bits  AES256-SHA256
    Accepted  TLSv1  256 bits  AES256-SHA
    Rejected  TLSv1  256 bits  CAMELLIA256-SHA
    Failed    TLSv1  256 bits  PSK-AES256-CBC-SHA
    Failed    TLSv1  128 bits  ECDHE-RSA-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  ECDHE-ECDSA-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  ECDHE-RSA-AES128-SHA256
    Failed    TLSv1  128 bits  ECDHE-ECDSA-AES128-SHA256
    Accepted  TLSv1  128 bits  ECDHE-RSA-AES128-SHA
    Rejected  TLSv1  128 bits  ECDHE-ECDSA-AES128-SHA
    Failed    TLSv1  128 bits  SRP-DSS-AES-128-CBC-SHA
    Failed    TLSv1  128 bits  SRP-RSA-AES-128-CBC-SHA
    Failed    TLSv1  128 bits  SRP-AES-128-CBC-SHA
    Failed    TLSv1  128 bits  DH-DSS-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  DHE-DSS-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  DH-RSA-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  DHE-RSA-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  DHE-RSA-AES128-SHA256
    Failed    TLSv1  128 bits  DHE-DSS-AES128-SHA256
    Failed    TLSv1  128 bits  DH-RSA-AES128-SHA256
    Failed    TLSv1  128 bits  DH-DSS-AES128-SHA256
    Rejected  TLSv1  128 bits  DHE-RSA-AES128-SHA
    Rejected  TLSv1  128 bits  DHE-DSS-AES128-SHA
    Rejected  TLSv1  128 bits  DH-RSA-AES128-SHA
    Rejected  TLSv1  128 bits  DH-DSS-AES128-SHA
    Rejected  TLSv1  128 bits  DHE-RSA-SEED-SHA
    Rejected  TLSv1  128 bits  DHE-DSS-SEED-SHA
    Rejected  TLSv1  128 bits  DH-RSA-SEED-SHA
    Rejected  TLSv1  128 bits  DH-DSS-SEED-SHA
    Rejected  TLSv1  128 bits  DHE-RSA-CAMELLIA128-SHA
    Rejected  TLSv1  128 bits  DHE-DSS-CAMELLIA128-SHA
    Rejected  TLSv1  128 bits  DH-RSA-CAMELLIA128-SHA
    Rejected  TLSv1  128 bits  DH-DSS-CAMELLIA128-SHA
    Rejected  TLSv1  128 bits  AECDH-AES128-SHA
    Failed    TLSv1  128 bits  ADH-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  ADH-AES128-SHA256
    Rejected  TLSv1  128 bits  ADH-AES128-SHA
    Rejected  TLSv1  128 bits  ADH-SEED-SHA
    Rejected  TLSv1  128 bits  ADH-CAMELLIA128-SHA
    Failed    TLSv1  128 bits  ECDH-RSA-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  ECDH-ECDSA-AES128-GCM-SHA256
    Failed    TLSv1  128 bits  ECDH-RSA-AES128-SHA256
    Failed    TLSv1  128 bits  ECDH-ECDSA-AES128-SHA256
    Rejected  TLSv1  128 bits  ECDH-RSA-AES128-SHA
    Rejected  TLSv1  128 bits  ECDH-ECDSA-AES128-SHA
    Failed    TLSv1  128 bits  AES128-GCM-SHA256
    Failed    TLSv1  128 bits  AES128-SHA256
    Accepted  TLSv1  128 bits  AES128-SHA
    Rejected  TLSv1  128 bits  SEED-SHA
    Rejected  TLSv1  128 bits  CAMELLIA128-SHA
    Failed    TLSv1  128 bits  PSK-AES128-CBC-SHA
    Rejected  TLSv1  128 bits  ECDHE-RSA-RC4-SHA
    Rejected  TLSv1  128 bits  ECDHE-ECDSA-RC4-SHA
    Rejected  TLSv1  128 bits  AECDH-RC4-SHA
    Rejected  TLSv1  128 bits  ADH-RC4-MD5
    Rejected  TLSv1  128 bits  ECDH-RSA-RC4-SHA
    Rejected  TLSv1  128 bits  ECDH-ECDSA-RC4-SHA
    Rejected  TLSv1  128 bits  RC4-SHA
    Rejected  TLSv1  128 bits  RC4-MD5
    Failed    TLSv1  128 bits  PSK-RC4-SHA
    Rejected  TLSv1  112 bits  ECDHE-RSA-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  ECDHE-ECDSA-DES-CBC3-SHA
    Failed    TLSv1  112 bits  SRP-DSS-3DES-EDE-CBC-SHA
    Failed    TLSv1  112 bits  SRP-RSA-3DES-EDE-CBC-SHA
    Failed    TLSv1  112 bits  SRP-3DES-EDE-CBC-SHA
    Rejected  TLSv1  112 bits  EDH-RSA-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  EDH-DSS-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  DH-RSA-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  DH-DSS-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  AECDH-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  ADH-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  ECDH-RSA-DES-CBC3-SHA
    Rejected  TLSv1  112 bits  ECDH-ECDSA-DES-CBC3-SHA
    Accepted  TLSv1  112 bits  DES-CBC3-SHA
    Failed    TLSv1  112 bits  PSK-3DES-EDE-CBC-SHA
    Rejected  TLSv1  0 bits    ECDHE-RSA-NULL-SHA
    Rejected  TLSv1  0 bits    ECDHE-ECDSA-NULL-SHA
    Rejected  TLSv1  0 bits    AECDH-NULL-SHA
    Rejected  TLSv1  0 bits    ECDH-RSA-NULL-SHA
    Rejected  TLSv1  0 bits    ECDH-ECDSA-NULL-SHA
    Failed    TLSv1  0 bits    NULL-SHA256
    Rejected  TLSv1  0 bits    NULL-SHA
    Rejected  TLSv1  0 bits    NULL-MD5

  Prefered Server Cipher(s):
ERROR: Could not create CTX object.


# NOTE: Ran on 2019-04-12_14-15-16
