#!/bin/sh
# ------------------------------------------------------ #
#
# Linux - Basic Base64 String Encoding/Decoding
#
# ------------------------------------------------------ #

### ENCODE
plaintext="Some string to encode to base64"; \
encoded_b64=$(echo -n ${plaintext} | base64 --wrap=0); \
echo $encoded_b64;


# ------------------------------------------------------ #

### DECODE
encoded_b64="U29tZSBzdHJpbmcgdG8gZW5jb2Rl"; \
decoded_b64=$(echo -e "${encoded_b64}" | base64 --decode); \
echo -e "${decoded_b64}";


# ------------------------------------------------------ #

### BASE64 ENCODE AN RSA PRIVATE-KEY
PRIVATE_KEY_ENCODED=$(echo -n \
"-----BEGIN RSA PRIVATE KEY-----
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKL
...
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
-----END RSA PRIVATE KEY-----" \
| base64 --wrap=0); \
echo -e "\n""PRIVATE_KEY_ENCODED = [ ${PRIVATE_KEY_ENCODED} ]""\n";


# ------------------------------------------------------ #
#
# MongoDB Replica-Set Keyfile
#

if [[ 0 -eq 1 ]]; then
# Convert keyfile to Base64 (to transport to associated replica servers as well as to store as a one-liner in password manager)
Keyfile_Base64=$(echo -n "$(cat /var/lib/mongo/keyfile)" | base64 --wrap=0); echo -e "\n""Keyfile_Base64 = [ ${Keyfile_Base64} ]""\n";
# Expand keyfile from Base64 into filepath "/var/lib/mongo/keyfile", which must be referenced by "/etc/mongod.conf" as [ keyFile: /var/lib/mongo/keyfile ] under the [ security: ] category)
Keyfile_Base64="PASTE_YOUR_BASE64_KEY_HERE"; Keyfile_AbsPath="/var/lib/mongo/keyfile"; Keyfile_Chown="mongod:mongod"; Keyfile_Chmod="0400"; if [ -f "${Keyfile_AbsPath}" ]; then cp "${Keyfile_AbsPath}" "${Keyfile_AbsPath}.$(date +'%Y%m%d_%H%M%S').bak"; fi; Keyfile_Plaintext=$(echo -e "${Keyfile_Base64}" | base64 --decode); Keyfile_Plaintext=$(echo -e "${Keyfile_Base64}" | base64 --decode); echo -e "${Keyfile_Plaintext}" > "${Keyfile_AbsPath}"; chown "${Keyfile_Chown}" "${Keyfile_AbsPath}"; chmod "${Keyfile_Chmod}" "${Keyfile_AbsPath}";
fi;


# ------------------------------------------------------ #