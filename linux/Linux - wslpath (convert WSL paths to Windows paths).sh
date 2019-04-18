#!/bin/bash

# wslpath 
#		--> pre-installed into Windows Subsystem for Linux environments
#		--> converts between windows & linux path-formats, especially add/removing "/mnt" before the %SYSTEMDRIVE%

TEST_PATH='C:\Windows\System32';

wslpath -u "${TEST_PATH}"; # /mnt/c/Windows/System32

wslpath -w $(wslpath -u "${TEST_PATH}"); # C:\Windows\System32     (example converts the path, then converts it to, ideally, the same path which was originally input)
