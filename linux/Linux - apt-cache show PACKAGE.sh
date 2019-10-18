#!/bin/bash

# Search-for (and inspect if-found) specific package(s) which may or may-not be installed in a given environment

# ------------------------------------------------------------
# apt-cache show pkg...
#           show performs a function similar to dpkg --print-avail; it displays the package records for the named packages.

PACKAGE_NAME="jq";
apt-cache show "${PACKAGE_NAME}";

# ------------------------------------------------------------
# apt-cache depends pkg...
#            depends shows a listing of each dependency a package has and all the possible other packages that can fulfill that dependency.

PACKAGE_NAME="jq";
apt-cache depends "${PACKAGE_NAME}";

# ------------------------------------------------------------
# apt-cache rdepends pkg...
#           rdepends shows a listing of each reverse dependency a package has.

PACKAGE_NAME="jq";
apt-cache rdepends "${PACKAGE_NAME}";

# ------------------------------------------------------------
# Citation(s)
#
#   linux.die.net  |  "apt-cache(8) - Linux man page"  |  https://linux.die.net/man/8/apt-cache
#
# ------------------------------------------------------------