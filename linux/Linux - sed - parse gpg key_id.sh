#!/bin/sh

# Linux - sed - parse GnuPG key_id's string out of gpg's returned LONG format-values

GNUPG_KEY_ID=$(gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^sec\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');

