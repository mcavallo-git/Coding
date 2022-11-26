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


# Run the following command:
find "/" -type 'f' \( -iname "system.pa" -o -iname "default.pa" \) -exec sed -r -e '/^(.*module-rescue-streams.*)$/ s/^#*/# /' -i '{}' \;;


# Restart the hassio_audio container
docker restart "hassio_audio";


# ------------------------------------------------------------

# Get sound card driver
udevadm info -a -p `udevadm info -q path -n /dev/snd/controlC0` | grep -i driver | grep -i snd


# Apply sound card driver to pulse ignorelist at startup
echo 'DRIVERS=="snd_hda_intel", ENV{PULSE_IGNORE}="1"' > "/etc/udev/rules.d/89-pulseaudio.rules"


# ------------------------------------------------------------

# Bash into hassio_audio container
docker exec -it "hassio_audio" '/bin/bash' 2>'/dev/null';


# Locate references to `module-rescue-streams` within the pulse system files
/bin/cat /etc/pulse/default.pa | /bin/grep -i rescue;
/bin/cat /etc/pulse/system.pa | /bin/grep -i rescue;

docker exec "hassio_audio" /bin/cat /etc/pulse/default.pa | /bin/grep -i rescue; \
docker exec "hassio_audio" /bin/cat /etc/pulse/system.pa | /bin/grep -i rescue;


# Truncate references to `module-rescue-streams` within the pulse system files
# sed -r -e "/module-rescue-streams/d" -i "/etc/pulse/default.pa";
# sed -r -e "/module-rescue-streams/d" -i "/etc/pulse/system.pa";


# Comment out lines containing `module-rescue-streams` within the pulse system files
docker exec "hassio_audio" /bin/sed -r -e '/^(.*module-rescue-streams.*)$/ s/^#*/# /' -i /etc/pulse/default.pa; \
docker exec "hassio_audio" /bin/sed -r -e '/^(.*module-rescue-streams.*)$/ s/^#*/# /' -i /etc/pulse/system.pa; \


# Restart the hassio_audio container
docker restart "hassio_audio";

# ------------------------------------------------------------

# All-in-one (fixed error) - Restart the hassio_audio container then immediately begin commenting out pulse's config files
docker restart "hassio_audio"; while [[ 1 -eq 1 ]]; do docker exec "hassio_audio" /bin/sed -r -e '/^(.*module-rescue-streams.*)$/ s/^#*/# /' -i /etc/pulse/default.pa; docker exec "hassio_audio" /bin/sed -r -e '/^(.*module-rescue-streams.*)$/ s/^#*/# /' -i /etc/pulse/system.pa; done;


# Locate OTHER containers which are storing the system.pa and default.pa rescue settings, and comment THOSE out (otherwise they get recreated upon hassio restart)
find "/" -type 'f' \( -iname "system.pa" -o -iname "default.pa" \) -exec echo '{}' \; -exec grep 'rescue' '{}' \;;

find "/" -type 'f' \( -iname "system.pa" -o -iname "default.pa" \) -exec grep -h 'rescue' '{}' \;;

find "/" -type 'f' \( -iname "system.pa" -o -iname "default.pa" \) -exec sed -r -e '/^(.*module-rescue-streams.*)$/ s/^#*/# /' -i '{}' \;;


# ------------------------------------------------------------
#
# Citation(s)
#
#   bbs.archlinux.org  |  "[solved] Pulseaudio warning about module-rescue-streams / Multimedia and Games / Arch Linux Forums"  |  https://bbs.archlinux.org/viewtopic.php?id=259601
#
#   github.com  |  "Audio stopped working on the host system · Issue #12 · home-assistant/plugin-audio · GitHub"  |  https://github.com/home-assistant/plugin-audio/issues/12#issuecomment-1179508339
#
#   stackoverflow.com  |  "linux - find -name "*.xyz" -o -name "*.abc" -exec to Execute on all found files, not just the last suffix specified - Stack Overflow"  |  https://stackoverflow.com/a/8888037
#
# ------------------------------------------------------------