
#
# grep target file's contents against octal-formatted CRLF line-endings:
#
grep -U $'\015' "~/myfile.txt";


#                                      v
# grep target file's contents against hex-formatted CRLF line-endings:
#                                      ^
grep -U $'\x0D' "~/myfile.txt";


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "bash - How to test whether a file uses CRLF or LF without modifying it? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/79713
#
# ------------------------------------------------------------