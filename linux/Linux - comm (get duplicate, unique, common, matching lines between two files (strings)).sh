#!/bin/bash
# ------------------------------------------------------------

# Print lines present in both files (e.g. matching/common/duplicate lines)
comm -12 file1 file2

# Print lines unique to either file
comm -3 file1 file2

# Print lines unique to the first file
comm -23 file1 file2

# Print lines unique to the second file
comm -13 file1 file2


# ------------------------------------------------------------

# Example - comm  (setup two files with contents, then compare)
VV="a"; echo -e "${VV}-1\n${VV}-2\n${VV}-3\n1\n22\n333" | sort > ${VV}.txt;
VV="b"; echo -e "${VV}-1\n${VV}-2\n${VV}-3\n1\n22\n333" | sort > ${VV}.txt;

comm -12 a.txt b.txt;  # Print lines present in both files

comm -3 a.txt b.txt;  # Print lines unique to either file

comm -23 a.txt b.txt;  # Print lines unique to the first file

comm -13 a.txt b.txt;  # Print lines unique to the second file



# ------------------------------------------------------------
#
# Citation(s)
#
#   zaiste.net  |  "Removing common lines between two files"  |  https://zaiste.net/posts/removing-common-lines-between-two-files/
#
# ------------------------------------------------------------