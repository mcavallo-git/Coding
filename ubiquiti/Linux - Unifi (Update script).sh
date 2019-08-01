#!/bin/sh

## Referenced from:  https://gist.github.com/ribasco/fff7d30b31807eb02b32bcf35164f11f

if [ "$(whoami)" != "root" ]; then
	echo -e "\n Error: This script must be ran as the root user.";
	echo -e "\n Exiting after 60 seconds...";
	Sleep 60;
	exit 1;
fi;

# java -version; ## Pre-Check to get current Java version installed (before edits are made)

ROOT_HOMEDIR="$(getent passwd $(whoami) | cut -d: -f6)";

GPG_DIRNAME="${ROOT_HOMEDIR}/gpg_keys";

mkdir -p "${GPG_DIRNAME}";

GPG_FILEPATH="${GPG_DIRNAME}/gpg_java8_20190215-040421-05002.txt";

echo \
"-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.5
Comment: Hostname: keyserver.ubuntu.com

mI0ES9/P3AEEAPbI+9BwCbJucuC78iUeOPKl/HjAXGV49FGat0PcwfDd69MVp6zUtIMbLgkU
OxIlhiEkDmlYkwWVS8qy276hNg9YKZP37ut5+GPObuS6ZWLpwwNus5PhLvqeGawVJ/obu7d7
gM8mBWTgvk0ErnZDaqaU2OZtHataxbdeW8qH/9FJABEBAAG0DUxhdW5jaHBhZCBWTEOImwQQ
AQIABgUCVsN4HQAKCRAEC6TrO3+B2tJkA/jM3b7OysTwptY7P75sOnIu+nXLPlzvja7qH7Wn
A23itdSker6JmyJrlQeQZu7b9x2nFeskNYlnhCp9mUGu/kbAKOx246pBtlaipkZdGmL4qXBi
+bi6+5Rw2AGgKndhXdEjMxx6aDPq3dftFXS68HyBM3HFSJlf7SmMeJCkhNRwiLYEEwECACAF
Akvfz9wCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRDCUYJI7qFIhucGBADQnY4V1xKT
1Gz+3ERly+nBb61BSqRx6KUgvTSEPasSVZVCtjY5MwghYU8T0h1PCx2qSir4nt3vpZL1luW2
xTdyLkFCrbbIAZEHtmjXRgQu3VUcSkgHMdn46j/7N9qtZUcXQ0TOsZUJRANY/eHsBvUg1cBm
3RnCeN4C8QZrir1CeA==
=CziK
-----END PGP PUBLIC KEY BLOCK-----" \
> "${GPG_FILEPATH}";

apt-key add "${GPG_FILEPATH}";

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list;

echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list;

apt-get -y update;

apt-get -y install oracle-java8-installer;

dpkg -l | grep oracle;

## Option 1

update-java-alternatives -l;

update-java-alternatives -s java-8-oracle;

# Option 2

# sudo apt-get install oracle-java8-set-default

service unifi stop;

apt purge oracle-java8-jdk -y;

sed -i 's/^JAVA_HOME/#JAVA_HOME/' /etc/default/unifi;

echo "JAVA_HOME="$( readlink -f "$( which java )" | sed "s:bin/.*$::" )"" >> /etc/default/unifi;
 
apt-get -y autoremove;

apt-get clean;

java -version; ## Check Java version after edits have been made

service unifi start;

reboot;
