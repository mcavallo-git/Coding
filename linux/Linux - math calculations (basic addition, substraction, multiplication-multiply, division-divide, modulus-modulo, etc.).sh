#!/bin/bash
# ------------------------------------------------------------
# Linux - math calculations (basic addition, substraction, multiplication-multiply, division-divide, etc.)
# ------------------------------------------------------------

# Addition
echo $(( 5 + 3 ));  # Outputs "8"
expr 5 + 3;         # Outputs "8"


# ------------------------------------------------------------

# Substraction
echo $(( 5 - 3 ));  # Outputs "2"
expr 5 - 3;         # Outputs "2"


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
echo "82.052 76.418 75.444 77.46" | tr " " "\n" | datamash mean 1 --round=2;  # Outputs "77.84"


# ------------------------------------------------------------
#
# Citation(s)
#
#   man7.org  |  "expr(1) - Linux manual page"  |  https://man7.org/linux/man-pages/man1/expr.1.html
#
# ------------------------------------------------------------