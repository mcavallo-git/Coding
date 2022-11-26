#!/bin/bash
# ------------------------------------------------------------
# HomeAssistant - Pulse audio hotfix-workaround
# ------------------------------------------------------------

# Open terminal to HomeAssistant OS (not using "Terminal & SSH" app), or, alternatively, directly access the computer/vm directly which is running target homassistant OS.


# Get sound card driver
udevadm info -a -p `udevadm info -q path -n /dev/snd/controlC0` | grep -i driver | grep -i snd


# Apply sound card driver to pulse ignorelist at startup
echo 'DRIVERS=="snd_hda_intel", ENV{PULSE_IGNORE}="1"' > "/etc/udev/rules.d/89-pulseaudio.rules"


# Bash into HomeAssistant's audio container
# docker exec -it "hassio_audio" '/bin/bash' 2>'/dev/null';


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "Audio stopped working on the host system · Issue #12 · home-assistant/plugin-audio · GitHub"  |  https://github.com/home-assistant/plugin-audio/issues/12#issuecomment-1179508339
#
# ------------------------------------------------------------