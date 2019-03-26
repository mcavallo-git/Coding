#
#	Check to see if string is a valid IPv4 (either with or without CIDR notation)
#

ARRAY_ITEMS_TO_TEST=( \
"0.0.0.0" \
"192.168.1.255" \
"0.0.0.0/27" \
"192.168.0.0/28" \
"192.168.2.30/32" \
" " \
"892.168.1.255" \
"892.168.1.255/32" \
"192.168.1.260" \
"192.168.2.30/33" \
);

LINEBREAK="\n\n---------------------------------------\n";

echo -e "${LINEBREAK}";

for EACH_ITEM in "${ARRAY_ITEMS_TO_TEST[@]}"; do

	if [[ ${EACH_ITEM} =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\/([0-9]|[1-2][0-9]|3[0-2]))?$ ]]; then

		# EACH_CIDR="${EACH_ITEM}";

		if [[ ${EACH_ITEM} =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(())$ ]]; then
			# Add "/32" to the end of string, if no CIDR notation is found - ex: 192.168.1.1
			EACH_CIDR="${EACH_ITEM}/32";
		else
			# Valid IPv4 in CIDR Notation - ex: 192.168.1.0/24
			EACH_CIDR="${EACH_ITEM}";
		fi;

		echo "  Valid IPv4: \"${EACH_CIDR}\"";

	else

		echo "  Invalid IPv4: \"${EACH_ITEM}\"";

	fi;

done;

echo -e "${LINEBREAK}";

