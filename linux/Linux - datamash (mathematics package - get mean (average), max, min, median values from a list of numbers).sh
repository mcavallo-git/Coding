# ------------------------------------------------------------

# Install datamash
apt-get -y update; apt-get -y install "datamash";

# ------------------------------
#
# datamash mean  -  get the average number of from a group of numbers
#

# mean  -  ex 1
seq 100 | datamash mean 1 --round=2;  # Outputs "50.50"

# mean  -  ex 2
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash mean 1 --round=2;  # Outputs "77.84"


# ------------------------------
#
# datamash max  -  get the highest/largest number of from a group of numbers
#

# max  -  ex 1
seq 100 | datamash max 1;  # Outputs "100"

# max  -  ex 2
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash max 1 --round=2;  # Outputs "82.05"


# ------------------------------
#
# datamash min  -  get the lowest/smallest number of from a group of numbers
#

# min  -  ex 1
seq 100 | datamash min 1;  # Outputs "1"

# min  -  ex 2
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash min 1 --round=2;  # Outputs "75.44"


# ------------------------------
#
# datamash multi-value  -  get multiple values at once
#

# max min mean median  -  ex 1
seq 100 | datamash max 1 min 1 mean 1 median 1 --round=2;


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