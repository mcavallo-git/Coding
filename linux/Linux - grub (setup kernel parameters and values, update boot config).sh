#!/bin/bash
exit 1;
# ------------------------------------------------------------
#
# Regenerate the GRUB2 configuration using the edited default file
#

# UEFI based systems - use the following command:
grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg;

# BIOS (NON-UEFI) based systems - use the following command:
grub2-mkconfig -o /boot/grub2/grub.cfg;


# ------------------------------------------------------------
#
# STOCK CONFIG FOR RHEL 7.3 LOCATED IN "/etc/default/grub":
#

GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="console=tty1 console=ttyS0 earlyprintk=ttyS0 rootdelay=300"
GRUB_DISABLE_RECOVERY="true"


# ------------------------------------------------------------
#
# Citation(s)
#
#   access.redhat.com  |  "Chapter 3. Listing of kernel parameters and values Red Hat Enterprise Linux 7 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/listing_of_kernel_parameters_and_values#sect-setting-kernel-parameters
#
# ------------------------------------------------------------