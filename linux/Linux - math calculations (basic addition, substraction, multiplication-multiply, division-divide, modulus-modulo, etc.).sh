#!/bin/bash
# ------------------------------------------------------------
# Linux - math calculations (basic addition, substraction, multiplication-multiply, division-divide, etc.)
# ------------------------------------------------------------

# Addition
echo $(( 5 + 3 ));  # Outputs "8"
expr 5 + 3;         # Outputs "8"
EXIT_CODE=$(( ${EXIT_CODE:-0} + 1 )); echo "${EXIT_CODE}";  # Outputs "1"


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
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash mean 1 --round=2;  # Outputs "77.84"

# Maximum
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash max 1 --round=2;  # Outputs "82.05"

# Minimum
echo "75.44 76.42 77.46 82.05" | tr " " "\n" | datamash min 1 --round=2;  # Outputs "75.44"


# ------------------------------------------------------------
#
# Citation(s)
#
#   man7.org  |  "expr(1) - Linux manual page"  |  https://man7.org/linux/man-pages/man1/expr.1.html
#
# ------------------------------------------------------------