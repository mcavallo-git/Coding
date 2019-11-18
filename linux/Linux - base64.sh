#!/bin/sh
# ------------------------------------------------------ #

# Linux - Basic Base64 String Encoding/Decoding

# ------------------------------------------------------ #

### ENCODE
plaintext="Some string to encode to base64"; \
encoded_b64=$(echo -n ${plaintext} | base64 --wrap=0); \
echo $encoded_b64;

# ------------------------------------------------------ #

### DECODE
encoded_b64="U29tZSBzdHJpbmcgdG8gZW5jb2Rl"; \
decoded_b64=$(echo -n ${encoded_b64} | base64 --decode); \
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
