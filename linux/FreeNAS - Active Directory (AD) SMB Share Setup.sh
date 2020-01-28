#!/bin/bash
# ------------------------------------------------------------
#
# Setting up FreeNAS with AD Authentication for SMB Share(s)
#
# See Citations (below), for tutorials
#
# Once you believe it is setup as-intended, you may either try to access the share directly (over the network), or
# you may run the following command(s) via the FreeNAS "Shell" (left bar in FreeNAS near the bottom):


# List known domain users
wbinfo -u
wbinfo --domain-users


# List known domain groups
wbinfo -g
wbinfo --domain-groups


#
# ------------------------------------------------------------
#
# Citation(s)
#
#   www.ixsystems.com  |  "FreeNAS unable to find domain controllers | iXsystems Community"  |  https://www.ixsystems.com/community/threads/freenas-unable-to-find-domain-controllers.30543/#post-209908
#
#   www.ixsystems.com  |  "[How-To] Properly setup FreeNAS 9.2.1.5 to use Active Directory folder/file/user permissions | iXsystems Community"  |  https://www.ixsystems.com/community/threads/how-to-properly-setup-freenas-9-2-1-5-to-use-active-directory-folder-file-user-permissions.20610/
#
# ------------------------------------------------------------