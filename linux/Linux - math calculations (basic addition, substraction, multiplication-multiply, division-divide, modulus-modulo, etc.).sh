#!/bin/bash
# ------------------------------------------------------------
# Linux - math calculations (basic addition, substraction, multiplication-multiply, division-divide, etc.)
# ------------------------------------------------------------

# Addition
echo $(( 5 + 3 ));  # Outputs "8"
expr 5 + 3;         # Outputs "8"
EXIT_CODE=$(( ${EXIT_CODE:-0} + 1 )); echo "${EXIT_CODE}";  # Outputs "1"

# Addition (via pipe)
echo -e "1\n2\n3\n4" | paste -s -d+ - | bc;  # Outputs "10"


# ------------------------------------------------------------

# Substraction
echo $(( 5 - 3 ));  # Outputs "2"
expr 5 - 3;         # Outputs "2"

# Substraction (via pipe)
echo -e "1\n2\n3\n4" | paste -s -d- - | bc;  # Outputs "-8"


# ------------------------------------------------------------

# Multiplication
echo $(( 5 * 3 ));  # Outputs "15"
expr 5 \* 3;        # Outputs "15"


# ------------------------------------------------------------

# Division
echo $(( 5 / 3 ));  # Outputs "1"
expr 5 / 3;         # Outputs "1"


# ------------------------------------------------------------

# Modulus/Modulo
echo $(( 10 % 6 ));  # Outputs "4"
expr 10 % 6;         # Outputs "4"


# ------------------------------------------------------------

# Mean/Average
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash mean 1 --round=2;  # Outputs "77.84"

# Maximum
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash max 1 --round=2;  # Outputs "82.05"

# Minimum
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash min 1 --round=2;  # Outputs "75.44"


# ------------------------------------------------------------

# Prepend leading zero
echo ".5" | sed -re "s/^0$/0.000/g" | sed -re "s/^\./0\0/g";  # Outputs "0.5"


# ------------------------------------------------------------

# Bytes -> Kilobytes
BYTES="1000000000"; KILOBYTES="$(echo "scale=3; (${BYTES}/(1024^1))" | bc -l | sed -re "s/^0$/0.000/g" | sed -re "s/^\./0\0/g";)"; echo "${KILOBYTES} KB";  # Outputs "976562.500 KB"

# Bytes -> Megabytes
BYTES="1000000000"; MEGABYTES="$(echo "scale=3; (${BYTES}/(1024^2))" | bc -l | sed -re "s/^0$/0.000/g" | sed -re "s/^\./0\0/g";)"; echo "${MEGABYTES} MB";  # Outputs "953.674 MB"

# Bytes -> Gigabytes
BYTES="1000000000"; GIGABYTES="$(echo "scale=3; (${BYTES}/(1024^3))" | bc -l | sed -re "s/^0$/0.000/g" | sed -re "s/^\./0\0/g";)"; echo "${GIGABYTES} GB";  # Outputs "0.931 GB"


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "az acr command to check the size of an image or list the size of all the images in repository · Issue #169 · Azure/acr · GitHub"  |  https://github.com/Azure/acr/issues/169#issuecomment-508259836
#
#   man7.org  |  "expr(1) - Linux manual page"  |  https://man7.org/linux/man-pages/man1/expr.1.html
#
#   stackoverflow.com  |  "Shell command to sum integers, one per line? - Stack Overflow"  |  https://stackoverflow.com/a/451204
#
# ------------------------------------------------------------