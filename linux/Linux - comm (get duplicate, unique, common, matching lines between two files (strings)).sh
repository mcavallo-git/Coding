#!/bin/bash
# ------------------------------------------------------------

# Print lines present in both file1 & file2
comm -12 file1 file2

# Print lines from file1 that do not match any line in file2  -  e.g. print lines in file1 not in file2, and vice versa
comm -3 file1 file2


# ------------------------------------------------------------

# Example - comm  (setup two files with contents, then compare)
VV="a"; echo -e "${VV}-1\n${VV}-2\n${VV}-3\n1\n22\n333" > ${VV}.txt
VV="b"; echo -e "${VV}-1\n${VV}-2\n${VV}-3\n1\n22\n333" > ${VV}.txt
comm -3 a.txt b.txt;  # Print lines from a.txt that do not match any line in b.txt




# ------------------------------------------------------------
#
# Citation(s)
#
#   zaiste.net  |  "Removing common lines between two files"  |  https://zaiste.net/posts/removing-common-lines-between-two-files/
#
# ------------------------------------------------------------