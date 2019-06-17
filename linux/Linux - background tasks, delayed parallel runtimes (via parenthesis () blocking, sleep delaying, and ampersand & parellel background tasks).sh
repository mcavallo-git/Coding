#!/bin/bash

echo "$(date +'%D %r')";

TEST_OUTPUT="${HOME}/tester_$(date +'%s')";

(sleep 5; echo "$(date +'%D %r')">"${TEST_OUTPUT}"; echo "whoami: $(whoami);">>"${TEST_OUTPUT}"; ) & echo "">/dev/null;

# (sleep 5; echo "$(date +'%D %r')">"${TEST_OUTPUT}"; echo "whoami: $(whoami);">>"${TEST_OUTPUT}"; ) & 

sleep 2 && cat "${TEST_OUTPUT}"; \
sleep 2 && cat "${TEST_OUTPUT}"; \
sleep 2 && cat "${TEST_OUTPUT}";
