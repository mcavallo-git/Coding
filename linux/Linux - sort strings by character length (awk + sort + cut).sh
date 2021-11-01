#!/bin/sh
# ------------------------------------------------------------
# Linux - sort strings by character length (awk + sort + cut)
# ------------------------------------------------------------

# General syntax - ASCENDING sort (longest strings at BOTTOM)
echo -e "12characters\n18stringcharacters\n6chars" | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2-;

# General syntax - DESCENDING sort (longest strings at TOP)
echo -e "12characters\n18stringcharacters\n6chars" | awk '{ print length, $0 }' | sort -r -n -s | cut -d" " -f2-;


# ------------------------------------------------------------
#
# Example)  Sort all filepaths in a git repository by full filepath string length
#

REPO="Coding"; find "${HOME}/Documents/GitHub/${REPO}" -not -path "${HOME}/Documents/GitHub/${REPO}/.git/*" | awk '{ print length, $0 }' | sort -r -n -s > "${HOME}/Desktop/repo-fullpaths__${REPO}.txt"; notepad "${HOME}/Desktop/repo-fullpaths__${REPO}.txt";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "bash - Sort a text file by line length including spaces - Stack Overflow"  |  https://stackoverflow.com/a/5917762
#
# ------------------------------------------------------------