#!/bin/bash
# ------------------------------------------------------------

# exiftool - get all metadata tags' names and their associated values for target file
exiftool -s example.mp4


# exiftool - get the date-created timestamp metadata for target file
exiftool -s -s -s -createdate example.mp4


# exiftool - get one, specific metadata tag's value for target file
#  |--> Example: get the "FileCreateDate" metadata tag's value for a target ".mp4" extensioned-file
exiftool -s -s -s -FileCreateDate example.mp4


# ------------------------------------------------------------
#
# Citation(s)
#
#   exiftool.org  |  "https://exiftool.org/install.html#Windows"  |  Installing ExifTool
#
#   photo.stackexchange.com  |  "https://photo.stackexchange.com/a/56678"  |  software - How can I extract just the value of a tag without the name using exiftool? - Photography Stack Exchange
#
#   stackexchange.com  |  "https://stackoverflow.com/a/53926462"  |  windows - How to change Media Created Date in Exiftool? - Stack Overflow
#
# ------------------------------------------------------------