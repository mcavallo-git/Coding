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
# Advanced sorting using 'LC_COLLATE=...' declaration
#

if [[ 1 -eq 1 ]]; then
echo -e "1\na\nB\n2\nA\nb" > test-sort.txt;
SORT="(none)"; echo -e "-----\nSORT=[ ${SORT} ]"; cat test-sort.txt;
SORT="general-numeric"; echo -e "-----\nSORT=[ ${SORT} ]"; sort --sort="${SORT}" test-sort.txt;
SORT="human-numeric"; echo -e "-----\nSORT=[ ${SORT} ]"; sort --sort="${SORT}" test-sort.txt;
SORT="month"; echo -e "-----\nSORT=[ ${SORT} ]"; sort --sort="${SORT}" test-sort.txt;
SORT="numeric"; echo -e "-----\nSORT=[ ${SORT} ]"; sort --sort="${SORT}" test-sort.txt;
SORT="random"; echo -e "-----\nSORT=[ ${SORT} ]"; sort --sort="${SORT}" test-sort.txt;
SORT="version"; echo -e "-----\nSORT=[ ${SORT} ]"; sort --sort="${SORT}" test-sort.txt;
echo "-----";
fi;


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
#   unix.stackexchange.com  |  "linux - Specify the sort order with LC_COLLATE so lowercase is before uppercase - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/361021
#
# ------------------------------------------------------------