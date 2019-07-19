#!/bin/bash

START_TIMESTAMP="$(date +'%Y%m%d%H%M%S')";

# ------------------------------------------------------------
#
# Generating a new GPG key
#		|--> Requires GPG v2.1.17 or later installed (for use of gpg's --full-generate-key)
#		|--> Refer to GitHub's help-article (e.g. their full-walkthrough) @ https://help.github.com/en/articles/generating-a-new-gpg-key
#
# Check GPG Version
# >   gpg --version | grep gpg;
#
# Begin the key-creation process by running:
# >   gpg --full-generate-key;
#
#		
#		1   *Enter*
#		
#		4096   *Enter*
#		
#		0   *Enter*
#		
#		y   *Enter*
#		
#		Real Name: [ GITHUB FULL-NAME ]   *Enter*
#		
#		Email address: [ GITHUB EMAIL, NON-HIDDEN & NON-PRIVATE ]   *Enter*
#		
#		Comment: [ If you want to add a comment ]   *Enter*
#		
#		O   *Enter*
#		
#		Wait for popup window --> enter into it:    [ GPG PASSWORD OF YOUR CHOOSING ]   *Enter*
#		
# ------------------------------------------------------------
#

KEYS_DIR="${HOME}/Desktop/GnuPG_Keys_${START_TIMESTAMP}";

if [ -d "$(dirname ${KEYS_DIR})" ]; then

	GnuPG_PrimaryKeyID=$(gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^sec\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');

	GnuPG_SecondaryKeyID=$(gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^ssb\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');

	GnuPG_PrimaryPrivateKey=$(gpg --armor --export-secret-keys "${GnuPG_PrimaryKeyID}");

	GnuPG_PrimaryPublicKey=$(gpg --armor --export "${GnuPG_PrimaryKeyID}");

	GnuPG_SecondaryPrivateKey=$(gpg --armor --export-secret-keys "${GnuPG_SecondaryKeyID}");

	GnuPG_SecondaryPublicKey=$(gpg --armor --export "${GnuPG_SecondaryKeyID}");

	mkdir -p "${KEYS_DIR}";

	echo "${GnuPG_PrimaryKeyID}" > "${KEYS_DIR}/GnuPG_PrimaryKeyID.txt";
	echo "${GnuPG_PrimaryPrivateKey}" > "${KEYS_DIR}/GnuPG_PrimaryKey.pem";
	echo "${GnuPG_PrimaryPublicKey}" > "${KEYS_DIR}/GnuPG_PrimaryKey.pub";
	echo "${GnuPG_SecondaryKeyID}" > "${KEYS_DIR}/GnuPG_SecondaryKeyID.txt";
	echo "${GnuPG_SecondaryPrivateKey}" > "${KEYS_DIR}/GnuPG_SecondaryKey.pem";
	echo "${GnuPG_SecondaryPublicKey}" > "${KEYS_DIR}/GnuPG_SecondaryKey.pub";

fi;

# ------------------------------------------------------------
#
# ** Description of the fields
# *** Field 1 - Type of record
#
#     - pub :: Public key
#     - crt :: X.509 certificate
#     - crs :: X.509 certificate and private key available
#     - sub :: Subkey (secondary key)
#     - sec :: Secret key
#     - ssb :: Secret subkey (secondary key)
#     - uid :: User id
#     - uat :: User attribute (same as user id except for field 10).
#     - sig :: Signature
#     - rev :: Revocation signature
#     - rvs :: Revocation signature (standalone) [since 2.2.9]
#     - fpr :: Fingerprint (fingerprint is in field 10)
#     - pkd :: Public key data [*]
#     - grp :: Keygrip
#     - rvk :: Revocation key
#     - tfs :: TOFU statistics [*]
#     - tru :: Trust database information [*]
#     - spk :: Signature subpacket [*]
#     - cfg :: Configuration data [*]
#
# ------------------------------------------------------------
#
#	Citation(s)
#
#		wiki.archlinux.org
#			"GnuPG"
#			 https://wiki.archlinux.org/index.php/GnuPG
#
#		www.gnuprg.org
#			"Using the GNU Privacy Guard"
#			 https://www.gnupg.org/documentation/manuals/gnupg.pdf
#
#		www.gnuprg.org
#			"Making and verifying signatures"
#			 https://www.gnupg.org/gph/en/manual/x135.html
#
#		git.gnupg.org
#			"GnuPG Details"
#		 	https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob_plain;f=doc/DETAILS
#
#		wiki.debian.org
#			"Using OpenPGP subkeys in Debian development"
#			 https://wiki.debian.org/Subkeys
#
#		help.github.com
#			"Generating a new GPG key"
#			 https://help.github.com/en/articles/generating-a-new-gpg-key
#
# ------------------------------------------------------------