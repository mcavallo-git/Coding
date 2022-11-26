#!/bin/bash
# ------------------------------------------------------------
# HomeAssistant - Pulse audio hotfix-workaround
# ------------------------------------------------------------
#
# Error message from HASSIO:
#  E: [pulseaudio] module-rescue-streams.c: module-rescue-stream is obsolete and should no longer be loaded. Please remove it from your configuration.
#
# ------------------------------------------------------------

# Open terminal to HomeAssistant OS (not using "Terminal & SSH" app), or, alternatively, directly access the computer/vm directly which is running target homassistant OS.


# Get sound card driver
udevadm info -a -p `udevadm info -q path -n /dev/snd/controlC0` | grep -i driver | grep -i snd


# Apply sound card driver to pulse ignorelist at startup
echo 'DRIVERS=="snd_hda_intel", ENV{PULSE_IGNORE}="1"' > "/etc/udev/rules.d/89-pulseaudio.rules"


# ------------------------------------------------------------

# Bash into hassio_audio container
docker exec -it "hassio_audio" '/bin/bash' 2>'/dev/null';


# Locate references to `module-rescue-streams` within the pulse system files
cat "/etc/pulse/default.pa" | grep -i rescue; cat "/etc/pulse/system.pa" | grep -i rescue;


# Truncate references to `module-rescue-streams` within the pulse system files
sed -r -e "/module-rescue-streams/d" -i "/etc/pulse/default.pa"; sed -r -e "/module-rescue-streams/d" -i "/etc/pulse/system.pa";


# Restart the docker container
docker restart "hassio_audio";



# ------------------------------------------------------------
#
# Citation(s)
#
#   bbs.archlinux.org  |  "[solved] Pulseaudio warning about module-rescue-streams / Multimedia and Games / Arch Linux Forums"  |  https://bbs.archlinux.org/viewtopic.php?id=259601
#
#   github.com  |  "Audio stopped working on the host system · Issue #12 · home-assistant/plugin-audio · GitHub"  |  https://github.com/home-assistant/plugin-audio/issues/12#issuecomment-1179508339
#
# ------------------------------------------------------------