#!/bin/bash
# ------------------------------------------------------------------------------------------------------ #
#

sudo -i;

openssl version;

# OVH-1 > OpenSSL 1.0.1e-fips 11 Feb 2013
# OVH-2 > OpenSSL 1.0.1e-fips 11 Feb 2013

# AWS-1 > OpenSSL 1.0.2g  1 Mar 2016
# AWS-2 > OpenSSL 1.0.2g  1 Mar 2016
# AWS-3 > OpenSSL 1.0.2g  1 Mar 2016
# AWS-4 > OpenSSL 1.0.2g  1 Mar 2016
# AWS-5 > OpenSSL 1.0.2g  1 Mar 2016

# ------------------------------------------------------------------------------------------------------ #
# Update [OpenSSL] to Avoid the Heartbleed bug

sudo -i;

TIMESTAMP_YMD_HMS="$(date +'%Y-%m-%d_%H:%M:%S')";
LOGFILE="${THIS_DIR}/logfile___${TIMESTAMP_YMD_HMS}.txt"
exec > >(tee -a "${LOGFILE}" )
exec 2>&1

openssl version

cd /usr/local/src
wget https://www.openssl.org/source/openssl-1.0.2-latest.tar.gz
tar -zxf openssl-1.0.2-latest.tar.gz

cd openssl-1.0.2a
./config
./config --prefix=/usr --with-ssl-dir=/usr/local/ssl --with-tcp-wrappers
make

make test
make install

mv /usr/bin/openssl /root/
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl


# ------------------------------------------------------------------------------------------------------ #

# OVH-1 (After Updates)
OpenSSL 1.0.2n  7 Dec 2017


# ------------------------------------------------------------------------------------------------------ #
# 2018-05-01 - Dockers
# Update [OpenSSL] to Avoid the Heartbleed bug

sudo -i;

# TIMESTAMP_YMD_HMS="$(date +'%Y-%m-%d_%H:%M:%S')";
# LOGFILE="${THIS_DIR}/logfile___${TIMESTAMP_YMD_HMS}.txt"
# exec > >(tee -a "${LOGFILE}" )
# exec 2>&1

openssl version

cd /usr/local/src
wget https://www.openssl.org/source/openssl-1.0.2-latest.tar.gz
tar -zxf openssl-1.0.2-latest.tar.gz

cd openssl-1.0.2o
./config
./config --prefix=/usr --with-ssl-dir=/usr/local/ssl --with-tcp-wrappers
make

make test
make install

mv /usr/bin/openssl /root/
# ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
ln -sf /usr/local/src/openssl-1.0.2o/apps/openssl /usr/bin/openssl


# ------------------------------------------------------------------------------------------------------ #

# Docker (After Updates)
root@docker [/]# openssl version
OpenSSL 1.0.2o  27 Mar 2018


# ------------------------------------------------------------------------------------------------------ #