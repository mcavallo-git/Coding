#!/bin/bash
# ------------------------------------------------------------
# UniFi - Update Firmware & Software on UCK-G2 (UniFi Cloud Key Gen 2)
# ------------------------------------------------------------
#
# Step 1/2 - UPDATE FIRMWARE  (updates the "UniFi OS UCK G2 Vx.xx.xx" on the Cloud Key)
#  |
#  |--> Get latest firmware URL @ https://www.ui.com/download/unifi/unifi-cloud-key-gen2   (updates the "UniFi OS UCK G2 Vx.xx.xx" on the Cloud Key)
#        |
#        |--> Update variable ${FIRMWARE_URL} (below) with updated URL
#

if [[ 1 -eq 1 ]]; then

# Firmware - UniFi OS - Cloud Key Gen2 x.xx.xx

FIRMWARE_URL="https://fw-download.ubnt.com/data/unifi-cloudkey/e9cc-UCKG2-2.1.11-1cf4bd8262b64919ac100cc5b69dc0b1.bin";  # v2.1.11  (2021-05-19)
# FIRMWARE_URL="https://fw-download.ubnt.com/data/unifi-cloudkey/4724-UCKG2-2.1.7-11ca020dba684770b2ebe6a832cb9911.bin";     # v2.1.7   (2021-04-12)
# FIRMWARE_URL="https://fw-download.ubnt.com/data/unifi-cloudkey/fbdc-UCKG2-2.0.27-2ceea428cab74b96bd456d67412b9a6c.bin";  # v2.0.27  (2021-01-29)
# FIRMWARE_URL="https://fw-download.ubnt.com/data/unifi-cloudkey/ca54-UCKG2-2.0.26-52af8c26f959414b918ee1b7cae94a64.bin";  # v2.0.26  (2021-01-21)
# FIRMWARE_URL="https://fw-download.ubnt.com/data/unifi-cloudkey/02ae-UCKG2-2.0.24-6a82e33e88174d1895a46ecb8953f562.bin";  # v2.0.24  (2020-12-17)
# FIRMWARE_URL="https://dl.ui.com/unifi/cloudkey/firmware/UCKG2/UCKG2.apq8053.v1.1.13.818cc5f.200430.0948.bin";            # v1.1.13  (2020-06-22)

ubnt-systool fwupdate "${FIRMWARE_URL}";

fi;


# ------------------------------------------------------------
#
# Step 2/2 - UPDATE SOFTWARE  (updates the "UniFi Network Version x.x.xx" on the Cloud Key)
#  |
#  |--> Get latest software URL from Ubiquiti's downloads portal @ https://www.ui.com/download/unifi/unifi-cloud-key-gen2
#        |
#        |--> Update variable ${SOFTWARE_URL} (below) with updated URL
#

if [[ 1 -eq 1 ]]; then

# Software -  UniFi Network Application x.x.xx for Debian/Ubuntu Linux and UniFi Cloud Key

# 1. Get latest software URL from Ubiquiti's download portal

SOFTWARE_URL="https://dl.ui.com/unifi/6.2.26/unifi_sysvinit_all.deb";  # v6.2.26  (2021-06-21)
# SOFTWARE_URL="https://dl.ui.com/unifi/6.2.25/unifi_sysvinit_all.deb";    # v6.2.25  (2021-05-19)
# SOFTWARE_URL="https://dl.ui.com/unifi/6.1.71/unifi_sysvinit_all.deb";  # v6.1.71  (2021-03-25)
# SOFTWARE_URL="https://dl.ui.com/unifi/6.0.45/unifi_sysvinit_all.deb";  # v6.0.45  (2021-01-27)
# SOFTWARE_URL="https://dl.ui.com/unifi/6.0.43/unifi_sysvinit_all.deb";  # v6.0.43  (2020-12-28)
# SOFTWARE_URL="https://dl.ui.com/unifi/6.0.41/unifi_sysvinit_all.deb";  # v6.0.41  (2020-12-03)

# 2. Open a SSH session using your favorite SSH/Telnet client program (for example PuTTY or the macOS/Linux Terminal). Access the Command Line Interface on the UDM using SSH. See how to log into a UniFi OS Console in the "Other Credentials" section of this article.

# 3. Access the UniFi OS shell (which is done if you're SSH'ed into the box)
LOCAL_INSTALL="/tmp/$(basename ${SOFTWARE_URL})";

# 4. Navigate to the /tmp directory:
cd "$(dirname ${LOCAL_INSTALL})";

# 5. Verify if there are any previous installation files present in the directory and delete them if applicable:
if [ -f "${LOCAL_INSTALL}" ]; then
rm -f "${LOCAL_INSTALL}";
fi;

# 6. Use the curl command with the previously copied link to download the UniFi Network installation file and store it in the /tmp directory.
# 7. Replace https://dl.ui.com/unifi/x.xx.xx_version/unifi_sysvinit_all.deb with the previously copied URL.
curl -o "${LOCAL_INSTALL}" "${SOFTWARE_URL}";

# 8. Wait for the firmware download process to complete and install the new version using the dpkg command:
if [[ 1 -eq 1 ]]; then
dpkg -i "${LOCAL_INSTALL}";
fi;

# 9. Wait for the installation process to complete and remove the unifi_sysvinit_all.deb file afterwards.
rm -f "${LOCAL_INSTALL}";

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   help.ui.com  |  "UniFi - UDM/UCK: How to Change the UniFi Network Version Using SSH – Ubiquiti Support and Help Center"  |  https://help.ui.com/hc/en-us/articles/216655518-UniFi-UDM-UCK-How-to-Change-the-Controller-Version-Using-SSH-
#
#   www.ui.com  |  "Ubiquiti - Downloads"  |  https://www.ui.com/download/unifi/unifi-cloud-key-gen2
#
# ------------------------------------------------------------