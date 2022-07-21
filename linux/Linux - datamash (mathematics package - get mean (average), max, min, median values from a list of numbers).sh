# ------------------------------------------------------------

# Install datamash
apt-get -y update; apt-get -y install "datamash";

# ------------------------------------------------------------

# datamash - Get the mean/average value from a list of numbers
seq 100 | datamash mean 1;

# datamash - Get the mean/average value from a list of numbers
echo "82.052 76.418 75.444 77.46" | tr " " "\n" | datamash mean 1

# datamash - Get the max, min, mean & median from a list of numbers:
seq 100 | datamash max 1 min 1 mean 1 median 1;


# ------------------------------------------------------------
#
# Citation(s)
# 
#   manpages.ubuntu.com  |  "Ubuntu Manpage: datamash - command-line calculations"  |  https://manpages.ubuntu.com/manpages/focal/man1/datamash.1.html
# 
#   unix.stackexchange.com  |  "text processing - Is there a way to get the min, max, median, and average of a list of numbers in a single command? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/202889
# 
#   www.gnu.org  |  "datamash - GNU Project - Free Software Foundation"  |  https://www.gnu.org/software/datamash/
#
# ------------------------------------------------------------