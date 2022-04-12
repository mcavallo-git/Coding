#!/bin/bash
# ------------------------------------------------------------
# Linux - seq (print a sequence of numbers)
# ------------------------------------------------------------
#
# SYNOPSIS
#        seq [OPTION]... LAST
#        seq [OPTION]... FIRST LAST
#        seq [OPTION]... FIRST INCREMENT LAST
#
# ------------------------------------------------------------

# seq - Example: Output a list of numbers

seq 5;
# returns:
# 1
# 2
# 3
# 4
# 5



# ------------------------------------------------------------

# seq - Example: Output a list of numbers (define first & last numbers)

SEQ_FIRST="5"; SEQ_LAST="10";
seq ${SEQ_FIRST} ${SEQ_LAST};
# returns:
# 5
# 6
# 7
# 8
# 9
# 10


# ------------------------------------------------------------

# seq - Example: Output a list of numbers (define first, increment & last numbers)

SEQ_FIRST="15"; SEQ_LAST="30"; SEQ_INCREMENT="3";
seq ${SEQ_FIRST} ${SEQ_INCREMENT} ${SEQ_LAST};
# returns:
# 15
# 18
# 21
# 24
# 27
# 30


# ------------------------------------------------------------

# seq - Example: Output a list of numbers left-padded with leading zeroes

seq --equal-width 1 10;
# returns:
# 01
# 02
# 03
# 04
# 05
# 06
# 07
# 08
# 09
# 10


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "bash sequence 00 01 ... 10 - Stack Overflow"  |  https://stackoverflow.com/a/11891206
#
#   www.geeksforgeeks.org  |  "seq command in Linux with Examples - GeeksforGeeks"  |  https://www.geeksforgeeks.org/seq-command-in-linux-with-examples/
#
# ------------------------------------------------------------