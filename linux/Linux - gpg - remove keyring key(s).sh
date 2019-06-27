#!/bin/bash
#
#	Remove a GnuPG keypair from the local keyring which matches a given fingerprint
#
#	If you are unsure what value(s) to use here, you may inspect your
#	current keyring via [ gpg --list-keys; ]  (look for the 40-character long hashes)
#

declare -a FINGERPRINTS_TO_REMOVE=( \
"9876543210ABCDEFGHIJKLMNOPQRSTUVWXYZ0123" \
"876543210ABCDEFGHIJKLMNOPQRSTUVWXYZ01234" \
"76543210ABCDEFGHIJKLMNOPQRSTUVWXYZ012345" \
"6543210ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456" \
);

UNIQUE_FINGERPRINTS_ARR=($(echo "${FINGERPRINTS_TO_REMOVE[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '));
for EACH_FINGERPRINT in "${UNIQUE_FINGERPRINTS_ARR[@]}"; do
	if [ ${#EACH_FINGERPRINT} -ne 40 ]; then
		echo "  ERROR - Fingerprint is not a 40-character long hash: \"${EACH_FINGERPRINT}\". Skipping...";
	else
		echo "  Attempting to remove GnuPG keypair matching fingerprint \"${EACH_FINGERPRINT}\"...";
		gpg --yes --delete-secret-and-public-key "${EACH_FINGERPRINT}"; # --yes  :::  Adds an additional confirm-before-delete step
	fi;
done;
