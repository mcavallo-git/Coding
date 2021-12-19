#!/bin/bash
# ------------------------------------------------------------
# Linux - Indentation styles (code-blocking, Kernighan & Ritchie (K&R), One True Brace (OTBS, 1TBS), Allman)
# ------------------------------------------------------------


#
# Kernighan & Ritchie (K&R) style
#  |
#  |--> Braces used only where needed, opening brace on same line as controlling statement, closing brace on its own line
#
if (x)
  a();
else {
  b();
  c();
}


#
# One True Brace style (1TBS/OTBS)
#  |
#  |--> Similar to K&R style, but all "if", "else", "while", and "for" statements have opening and closing braces
#
if (x) {
  a();
} else {
  b();
  c();
}


#
# Allman style
#  |
#  |--> Similar to 1TBS/OTBs, but requires opening/closing braces to be placed on a line by themselves
#
if (x)
{
  a();
}
else
{
  b();
  c();
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   en.wikipedia.org  |  "Indentation style - Wikipedia"  |  https://en.wikipedia.org/wiki/Indentation_style#K&R_style
#
#   softwareengineering.stackexchange.com  |  "indentation - What is the difference between K&R and One True Brace Style (1TBS) styles? - Software Engineering Stack Exchange"  |  https://softwareengineering.stackexchange.com/a/99546
#
# ------------------------------------------------------------