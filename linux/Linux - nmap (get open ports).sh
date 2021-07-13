#!/bin/bash


# apt-get -y install nmap

# yum -y install nmap


nmap -T aggressive -A -v 127.0.0.1 -p 1-65535;

nmap -T aggressive -A -v 127.0.0.1 -p 80


nmap -p 443,80 --script http-methods localhost;

nmap -p 443,80 --script http-methods 127.0.0.1;


# ------------------------------------------------------------
# from [ man nmap ]:
#
# ...
#
#           PORT SPECIFICATION AND SCAN ORDER:
#             -p <port ranges>: Only scan specified ports
#               Ex: -p22; -p1-65535; -p U:53,111,137,T:21-25,80,139,8080,S:9
#             --exclude-ports <port ranges>: Exclude the specified ports from scanning
#
# ...
#
#       -T paranoid|sneaky|polite|normal|aggressive|insane (Set a timing template)
#           While the fine-grained timing controls discussed in the previous section are powerful and effective, some
#           people find them confusing. Moreover, choosing the appropriate values can sometimes take more time than
#           the scan you are trying to optimize. So Nmap offers a simpler approach, with six timing templates. You can
#           specify them with the -T option and their number (0–5) or their name. The template names are paranoid (0),
#           sneaky (1), polite (2), normal (3), aggressive (4), and insane (5). The first two are for IDS evasion.
#           Polite mode slows down the scan to use less bandwidth and target machine resources. Normal mode is the
#           default and so -T3 does nothing. Aggressive mode speeds scans up by making the assumption that you are on
#           a reasonably fast and reliable network. Finally insane mode assumes that you are on an extraordinarily
#           fast network or are willing to sacrifice some accuracy for speed.
#
# ...
#
#       -A (Aggressive scan options)
#           This option enables additional advanced and aggressive options. Presently this enables OS detection (-O),
#           version scanning (-sV), script scanning (-sC) and traceroute (--traceroute).  More features may be added
#           in the future. The point is to enable a comprehensive set of scan options without people having to
#           remember a large set of flags. However, because script scanning with the default set is considered
#           intrusive, you should not use -A against target networks without permission. This option only enables
#           features, and not timing options (such as -T4) or verbosity options (-v) that you might want as well.
#           Options which require privileges (e.g. root access) such as OS detection and traceroute will only be
#           enabled if those privileges are available.
#
# ...
#
#       -v (Increase verbosity level), -vlevel (Set verbosity level)
#           Increases the verbosity level, causing Nmap to print more information about the scan in progress. Open
#           ports are shown as they are found and completion time estimates are provided when Nmap thinks a scan will
#           take more than a few minutes. Use it twice or more for even greater verbosity: -vv, or give a verbosity
#           level directly, for example -v3.
#
# ...
#
# ------------------------------------------------------------