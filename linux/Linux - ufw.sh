# ------------------------------------------------------------
#
# Linux - UFW
#           (e.g. "Uncomplicated Firewall")
#
# ------------------------------------------------------------
#
# General Ruleset
#

ufw allow 22/tcp;  # allow ssh/sftp-requests (22)

ufw allow 24/tcp;  # allow sftp-requests (24)

ufw allow 80/tcp;  # allow web-requests (80)

ufw allow 443/tcp; # allow web-requests (443)

ufw default deny incoming;  # deny other incoming requests, by default

ufw default allow outgoing; # allow all outgoing requests, by default

ufw logging on; # enable logging

ufw enable; # enable ufw module


# ------------------------------------------------------------

ufw status numbered; # List UFW rules by-ID

ufw delete RULE_ID;  # Delete UFW rules by-ID


# ------------------------------------------------------------
#
# UFW | Service Check
#  |--> Check whether UFW service exists locally
#
SERVICE_NAME="ufw"; SERVICE_MATCHES=$(service --status-all 2>/dev/null | sed --regexp-extended --quiet --expression='s/^\ \[ (\+|\-) \]\ \ ('${SERVICE_NAME}')$/\2/p');
test -n "${SERVICE_MATCHES}" && echo "Service \"${SERVICE_NAME}\" WAS found as a local service" || echo "Service \"${SERVICE_NAME}\" NOT found as a local service";



# ------------------------------------------------------------
#
# UFW | IPv6 Pinging
#  |--> Check whether UFW currently allows IPv6 Ping requests or not, then asks to enable/disable it (depending on status)
#
SERVICE_NAME="ufw";
SERVICE_MATCHES=$(service --status-all 2>/dev/null | sed --regexp-extended --quiet --expression='s/^\ \[ (\+|\-) \]\ \ ('${SERVICE_NAME}')$/\2/p');
if [ -z "${SERVICE_MATCHES}" ]; then
	echo "Error - Service \"${SERVICE_NAME}\" NOT found as a local service";
	exit 1;
else
	ALLOW_ICMPv6_ECHO=$(cat "/etc/ufw/before6.rules" | sed --regexp-extended --quiet --expression='s/^-A ufw6-before-input -p icmpv6 --icmpv6-type echo-request -j ACCEPT$/\0/p');
	if [ -n "${ALLOW_ICMPv6_ECHO}" ]; then
		echo -e "\n""IPv6 Pinging is currently ENABLED";
		read -p "DISABLE IPv6 Pinging, Now? ( Y/N )  " -n 1 -t 20 -r;
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sed \
				--regexp-extended \
				--in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" \
				--expression='/^# Allow ICMPv6 Pinging$/d' \
				--expression='/^-A ufw6-before-input -p icmpv6 --icmpv6-type echo-request -j ACCEPT$/d' \
				"/etc/ufw/before6.rules";
		fi;
	else
		echo -e "\n""IPv6 Pinging is currently DISABLED"; read -p "ENABLE IPv6 Pinging, Now? ( Y/N )  " -n 1 -t 20 -r;
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sed \
				--regexp-extended \
				--in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" \
				--expression='/^#.+line or these rules.+$/d' \
				--expression='/^COMMIT$/i\# Allow ICMPv6 Pinging\n-A ufw6-before-input -p icmpv6 --icmpv6-type echo-request -j ACCEPT\n# dont delete the COMMIT line or these rules wont be processed' \
				"/etc/ufw/before6.rules";
		fi;
	fi;
fi;


# ------------------------------------------------------------
#
# UFW | IPv6 Multicast
#  |--> Check whether UFW currently allows IPv6 Multicast requests or not, then asks to enable/disable it (depending on status)
#
SERVICE_NAME="ufw";
SERVICE_MATCHES=$(service --status-all 2>/dev/null | sed --regexp-extended --quiet --expression='s/^\ \[ (\+|\-) \]\ \ ('${SERVICE_NAME}')$/\2/p');
if [ -z "${SERVICE_MATCHES}" ]; then
	echo "Error - Service \"${SERVICE_NAME}\" NOT found as a local service";
	exit 1;
else
	ALLOW_ICMPv6_MULTICAST=$(cat "/etc/ufw/before6.rules" | sed --regexp-extended --quiet --expression='s/^-A ufw6-before-input -p icmpv6 --icmpv6-type 130 -j ACCEPT$/\0/p');
	if [ -n "${ALLOW_ICMPv6_MULTICAST}" ]; then
		echo -e "\n""IPv6 Multicast is currently ENABLED";
		read -p "DISABLE IPv6 Multicast, Now? ( Y/N )  " -n 1 -t 20 -r;
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sed \
				--regexp-extended \
				--in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" \
				--expression='/^# Allow ICMPv6 Multicast$/d' \
				--expression='/^-A ufw6-before-input -p icmpv6 --icmpv6-type 130 -j ACCEPT$/d' \
				"/etc/ufw/before6.rules";
		fi;
	else
		echo -e "\n""IPv6 Multicast is currently DISABLED";
		read -p "ENABLE IPv6 Multicast, Now? ( Y/N )  " -n 1 -t 20 -r;
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sed \
				--regexp-extended \
				--in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" \
				--expression='/^#.+line or these rules.+$/d' \
				--expression='/^COMMIT$/i\# Allow ICMPv6 Multicast\n-A ufw6-before-input -p icmpv6 --icmpv6-type 130 -j ACCEPT\n# dont delete the COMMIT line or these rules wont be processed' \
				"/etc/ufw/before6.rules";
		fi;
	fi;
fi;

# ------------------------------------------------------------
#
# Citation(s)
#
#
#		digitalocean.com  |  "UFW Essentials: Common Firewall Rules and Commands"  |  https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
#
#		digitalocean.com  |  "How To Set Up a Firewall with UFW on Ubuntu 18.04"  |  https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
#
#		askubuntu.com  |  "How to enable ufw firewall to allow icmp response?"  |  https://askubuntu.com/a/10314
#
#		manpages.ubuntu.com  |  "Ubuntu manuals - NAME"  |  https://manpages.ubuntu.com/manpages/trusty/man8/ufw.8.html
#
# ------------------------------------------------------------
