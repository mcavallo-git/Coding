#!/bin/sh

# Check available ciphers for current device
curl "https://www.howsmyssl.com/a/check"

# ------------------------------------------------------------

# Check available ciphers for current device > Save to JSON file in user's home-directory
curl "https://www.howsmyssl.com/a/check" > "${HOME}/ciphers.json";
cat "${HOME}/ciphers.json"

# ------------------------------------------------------------
# Citation(s)
#
#   unix.stackexchange.com  |  "How to see list of curl ciphers?"  |  https://unix.stackexchange.com/a/208423
#
# ------------------------------------------------------------