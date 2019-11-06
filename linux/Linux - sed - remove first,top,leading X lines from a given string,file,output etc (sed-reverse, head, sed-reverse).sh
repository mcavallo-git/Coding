#!/bin/sh
#
# Remove top 1 line from piped output
#

df -h | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d'; 



#
# Remove top X lines from piped output
#
SED_REVERSE_METHOD1='1!G;h;$!d';  # use with  [ sed '1!G;h;$!d' ]
SED_REVERSE_METHOD2='1!G;h;$p';   # use with  [ sed -n '1!G;h;$p' ]
TOP_LINES_TO_SLICE=5;

TEST_STR="1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15"; \
echo "\${TEST_STR}, as-is (not-reversed):"; echo -e "${TEST_STR}"; \
 \
echo -e "\n\${TEST_STR}, reversed (using SED_REVERSE_METHOD1):";\
echo -e "${TEST_STR}" | sed "${SED_REVERSE_METHOD1}" | head -n -${TOP_LINES_TO_SLICE} | sed "${SED_REVERSE_METHOD1}"; \
echo -e "\n"; \
 \
echo -e "\n\${TEST_STR}, reversed (using SED_REVERSE_METHOD2):"; \
echo -e "${TEST_STR}" | sed -n "${SED_REVERSE_METHOD2}" | head -n -${TOP_LINES_TO_SLICE} | sed -n "${SED_REVERSE_METHOD2}"; echo -e "\n";



# ------------------------------------------------------------
#
# Citation(s)
#
# 	stackoverflow.com  |  "How can I reverse the order of lines in a file?"  |  https://stackoverflow.com/a/744093
#
# ------------------------------------------------------------