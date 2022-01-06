#!/bin/bash
exit 1;

# ------------------------------------------------------------
#
# Install 7-Zip Package
#

if [ $(which 7z 2>'/dev/null' | wc -l;) -eq 0 ]; then
	if [[ -n "$(command -v apt 2>'/dev/null';)" ]]; then  # Distros: Debian, Ubuntu, etc.
		sudo apt-get -y update && sudo apt-get -y install p7zip-full;
	elif [ $(which yum 2>'/dev/null' | wc -l;) -gt 0 ]; then # Distros: Fedora, Oracle Linux, Red Hat Enterprise Linux, CentOS, etc.
		wget "https://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/Packages/p/p7zip-16.02-10.el7.x86_64.rpm";
		wget "https://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/Packages/p/p7zip-plugins-16.02-10.el7.x86_64.rpm";
		sudo rpm -U --quiet "p7zip-16.02-10.el7.x86_64.rpm";
		sudo rpm -U --quiet "p7zip-plugins-16.02-10.el7.x86_64.rpm";
		rm -f "p7zip-16.02-10.el7.x86_64.rpm";
		rm -f "p7zip-plugins-16.02-10.el7.x86_64.rpm";
	fi;
fi;


# ------------------------------------------------------------
# Compress a directory to ".7z"

FILEPATH_TO_COMPRESS="/var/www/html";
FILEPATH_ARCHIVE_7Z="${HOME}/var-www-html-$(date +'%Y%m%d_%H%M%S').7z";
7z a "${FILEPATH_ARCHIVE_7Z}" -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on "${FILEPATH_TO_COMPRESS}";


# ------------------------------------------------------------
# Unpack a ".7z" archive (into a given directory)

FILEPATH_ARCHIVE_7Z="${HOME}/var-www-html-20191101_183748.7z";
DIR_TO_EXTRACT_INTO="$(basename ${FILEPATH_ARCHIVE_7Z})_unpacked";
mkdir -p "${DIR_TO_EXTRACT_INTO}";
7z x "${FILEPATH_ARCHIVE_7Z}" -o${DIR_TO_EXTRACT_INTO};


# ------------------------------------------------------------
# Unpack a all 7z archives in target-directory into a given directory

DIR_CONTAINING_7Z="${HOME}/to-unpack" && \
DIR_TO_EXTRACT_INTO="${HOME}/unpacked" && \
mkdir -p "${DIR_TO_EXTRACT_INTO}" && \
7z x "${DIR_CONTAINING_7Z}/*.7z" -o${DIR_TO_EXTRACT_INTO};


# ------------------------------------------------------------
# Settings Laid-Out / Explained
#   |--> 7z Compression using LZMA Algorithm w/ Ultra-Compression

FILEPATH_TO_COMPRESS="/var/www/html";
FILEPATH_ARCHIVE_7Z="${HOME}/var-www-html-$(date +'%Y%m%d_%H%M%S').7z";
DO_COMPRESS="a";
FILE_EXT="7z";      ### CHOICES: {7z, zip, gzip, bzip2, tar}     ### DEFAULT: {7z}
COMP_METHOD="LZMA"; ### CHOICES: {LZMA, LZMA2, PPMd, BZip2, Deflate, Delta, BCJ, BCJ2, Copy}     ### DEFAULT: {LZMA}
COMP_LEVEL="9";     ### CHOICES: {0-9}     ### DEFAULT: { ? }     ### ULTRA-MODE: 9, MAXIMUM-MODE: 7
FAST_BYTES="64";    ### CHOICES: { ? }
DICT_SIZE="32m";    ### CHOICES: { [ 2^x ][ b|k|m ] }    ### DEFAULT: { 16m }
SOLID_ARCH="on";    ### CHOICES: {on, off}
7z ${DO_COMPRESS} "${FILEPATH_ARCHIVE_7Z}" -t${FILE_EXT} -m0=${COMP_METHOD} -mx=${COMP_LEVEL} -mfb=${FAST_BYTES} -md=${DICT_SIZE} -ms=${SOLID_ARCH} "${FILEPATH_TO_COMPRESS}";

### Equivalent to:
# 7z a "${FILEPATH_ARCHIVE_7Z}" -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on "${FILEPATH_TO_COMPRESS}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   gist.github.com  |  "7zip install on Linux -- Ubuntu and Fedora or CentOS / RHEL · GitHub"  |  https://gist.github.com/P7h/9fcccc54596ad05764128dec6f6cf78d
#
# ------------------------------------------------------------