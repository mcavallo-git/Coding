#!/bin/bash
#
# Linux - Arrays
#


# ------------------------------------------------------------
#
# Associative Arrays in Bash
#   |--> Note: Bash only supports one-dimensional arrays,
#              e.g. you can't store arrays within arrays
#
unset DAT_ARRAY; declare -A DAT_ARRAY; # Re-instantiate bash array
DAT_ARRAY+=(["Key One"]="Val One");
DAT_ARRAY+=(["Key Two"]="Val Two");
DAT_ARRAY+=(["Key A"]="Val A");
DAT_ARRAY+=(["Key B"]="Val B");
for DAT_KEY in "${!DAT_ARRAY[@]}"; do
DAT_ITEM="${DAT_ARRAY[${DAT_KEY}]}";
echo "DAT_ARRAY[${DAT_KEY}] = ${DAT_ITEM}";
done;


# ------------------------------------------------------------
#
# Two Arrays Keyed with the same indices
#
unset ARR_CONTAINER_IDS; declare -A ARR_CONTAINER_IDS; # Re-instantiate bash array
unset ARR_DOCKER_IMAGES; declare -A ARR_DOCKER_IMAGES; # Re-instantiate bash array

DOCKER_CONTAINER_IDS=$(docker ps --format "{{.ID}}");

CHOICE_KEY=0;
for EACH_CONTAINER_ID in ${DOCKER_CONTAINER_IDS[@]}; do
	CHOICE_KEY=$((CHOICE_KEY+1));
	EACH_DOCKER_IMAGE=$(docker ps --format "{{.Image}}" --filter "id=${EACH_CONTAINER_ID}");
	ARR_CONTAINER_IDS+=(["${CHOICE_KEY}"]="${EACH_CONTAINER_ID}");
	ARR_DOCKER_IMAGES+=(["${CHOICE_KEY}"]="${EACH_DOCKER_IMAGE}");
done;

if [ ${CHOICE_KEY} -le 0 ]; then
	echo "Error: No Containers found to be running - Please start a container then rerun \"${0}\"";
else
	echo "Found the following dockers, locally:";
	for EACH_KEY in "${!ARR_CONTAINER_IDS[@]}"; do
		EACH_CONTAINER_ID="${ARR_CONTAINER_IDS[${EACH_KEY}]}";
		EACH_DOCKER_IMAGE="${ARR_DOCKER_IMAGES[${EACH_KEY}]}";
		echo "        ${EACH_KEY}	-  ${EACH_DOCKER_IMAGE}  (${EACH_CONTAINER_ID})";
	done;

	MAX_READ_WAIT=20; read -p "Select: " -t ${MAX_READ_WAIT} -r;
	if [ -z "${REPLY}" ]; then
		echo "Error: Response timed out after ${MAX_READ_WAIT}s";
	else
		USER_SELECTION_KEY=$((0+"${REPLY}"));
		if [ -z "${ARR_CONTAINER_IDS[${USER_SELECTION_KEY}]}" ]; then
			echo "Error: Invalid Selection of \"${REPLY}\"";
		else
			E1="LINES=$(tput lines)";
			E2="COLUMNS=$(tput cols)";
			CONTAINER_ID="${ARR_CONTAINER_IDS[${USER_SELECTION_KEY}]}";
			DOCKER_IMAGE="${ARR_DOCKER_IMAGES[${USER_SELECTION_KEY}]}";
			echo "        |----> ID: \"${CONTAINER_ID}\"";
			echo "        |-> Image: \"${DOCKER_IMAGE}\"";
			docker exec -e "${E1}" -e "${E2}" -it "${CONTAINER_ID}" "/bin/bash";
		fi;
	fi;
fi;


# -------------------------------------------------------------
#
# Non-Associative Arrays in Bash
#

DAT_ARRAY=("Item-One" "Item-One" "Item-Two" "Item-A" "Item-A" "Item-B");
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
echo "${DAT_ITEM}";
done;

# #  ^
# #  Methods have equivalent output
# #  v

DAT_ARRAY=();
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-Two");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-B");
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
echo "${DAT_ITEM}";
done;

# #  ^
# #  Methods have equivalent output
# #  v

DAT_ARRAY=( \
"Item-One" \
"Item-One" \
"Item-Two" \
"Item-A" \
"Item-A" \
"Item-B" \
);
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
echo "${DAT_ITEM}";
done;



# -------------------------------------------------------------
#
#	Sort an array, remove duplicates from it, then walk through it
#
#		NOTE
#			Each item in the array must NOT have spaces in them for
#			the [ tr ] (translate) method to sort items as-intended
#

DAT_ARRAY=("Item-One" "Item-One" "Item-Two" "Item-A" "Item-A" "Item-B");
DAT_ARRAY_SORTED_NO_DUPES=($(echo "${DAT_ARRAY[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '));
for DAT_ITEM in "${DAT_ARRAY_SORTED_NO_DUPES[@]}"; do
echo "${DAT_ITEM}";
done;



# -------------------------------------------------------------
#
#	Reference Arrays as variables whose variable-names are built from other arrays' string-values.
#	Then, combine all arrays and find unique items amongst their net result;
#

DAT_A_ARRAY=("Item-One" "Item-Two");
DAT_B_ARRAY=("Item-A" "Item-B");
DAT_C_ARRAY=("Item-B" "Item-One");
DAT_D_ARRAY=("Item-B" "Item-C" "Item-Two" "Item-Two");

ARRAY_LETTERS=("A" "B" "C" "D");

echo -e "\n\n";

ALL_ITEMS_ARRAY=();

for EACH_ARRAY_LETTER in "${ARRAY_LETTERS[@]}"; do

	EACH_ARRAY_VARNAME=DAT_${EACH_ARRAY_LETTER}_ARRAY[@];

	EACH_DAT_ARRAY=("${!EACH_ARRAY_VARNAME}");

	for EACH_ITEM in "${EACH_DAT_ARRAY[@]}"; do

		ALL_ITEMS_ARRAY+=("${EACH_ITEM}");

		echo "\$ALL_ITEMS_ARRAY+=(\"${EACH_ITEM}\")";

	done;
	
done;

echo -e "\n\n";

echo "\$ALL_ITEMS_ARRAY=(${ALL_ITEMS_ARRAY[@]})";

ALL_ITEMS_SORTED_UNIQUE=($(echo "${ALL_ITEMS_ARRAY[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '));

echo -e "\n\n";

echo "\$ALL_ITEMS_SORTED_UNIQUE=(${ALL_ITEMS_SORTED_UNIQUE[@]})";

echo -e "\n\n";

# -------------------------------------------------------------
#
# Citation(s)
#
# 	gnu.org  |  "6.7 Arrays"  |  https://www.gnu.org/software/bash/manual/html_node/Arrays.html
#
# 	linuxjournal.com  |  "Bash Associative Arrays"  |  https://www.linuxjournal.com/content/bash-associative-arrays
#
# 	stackoverflow.com  |  "Loop through an array of strings in Bash?"  |  https://stackoverflow.com/a/8880633
#
# 	stackoverflow.com  |  "Multidimensional associative arrays in Bash"  |  https://stackoverflow.com/a/6151190
#
# ------------------------------------------------------------