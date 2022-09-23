#!/bin/bash
#
# Bash Array Variables
#   |--> bash shell only, doesnt work in sh, etc.
#
# -------------------------------------------------------------
#
# Indexed Arrays
#   |--> Syntax:  declare -a VARNAME;
#   |--> Note:  Bash only supports one-dimensional arrays, e.g. no sub-arrays (no arrays within arrays)
#   |--> Note:  declare without argument -a or -A defaults to using -a (indexed array)
#

unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=("Val-1");
DAT_ARRAY+=("Val-2");
DAT_ARRAY+=("Val-3");
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
echo "------------------------------";
echo "${DAT_ITEM}";
done;


unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Val-1");
DAT_ARRAY+=("Val-2");
DAT_ARRAY+=("Val-3");
for (( i=0; i<${#DAT_ARRAY[@]}; i++ )); do
echo "\${DAT_ARRAY[$i]} = [ ${DAT_ARRAY[$i]} ]";
done;
ARRAY_LENGTH=${#DAT_ARRAY[@]};
echo "\${ARRAY_LENGTH} = [ ${ARRAY_LENGTH} ]";


# ------------------------------------------------------------
#
# Associative Arrays (in Bash)
#   |--> Syntax:  declare -A VARNAME;
#   |--> Note:  Bash only supports one-dimensional arrays, e.g. no sub-arrays (no arrays within arrays)
#

unset DAT_ARRAY; declare -A DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=(["Key A"]="Val One");
DAT_ARRAY+=(["Key B"]="Val Two");
DAT_ARRAY+=(["Key C"]="Val Three");
DAT_ARRAY+=(["Key A"]="Overwrite A");
DAT_ARRAY+=(["Key B"]="Overwrite B");
for DAT_KEY in "${!DAT_ARRAY[@]}"; do
DAT_ITEM="${DAT_ARRAY[${DAT_KEY}]}";
echo "DAT_ARRAY[${DAT_KEY}] = ${DAT_ITEM}";
done;


# ------------------------------------------------------------
#
# Implode Array
#  |--> Combine items in an array using a given delimiter
#

# Implode - Indexed Array
unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Val-1");
DAT_ARRAY+=("Val-2");
DAT_ARRAY+=("Val-3");
function implode { local IFS="$1"; shift; echo "$*"; };
implode $'\n' "${DAT_ARRAY[@]}";


# Implode - Associative Array
unset DAT_ARRAY; declare -A DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=(["Key A"]="Val One");
DAT_ARRAY+=(["Key B"]="Val Two");
DAT_ARRAY+=(["Key C"]="Val Three");
function implode { local IFS="$1"; shift; echo "$*"; };
implode $'\n' "${!DAT_ARRAY[@]}";  # Implode Keys
implode $'\n' "${DAT_ARRAY[@]}";   # Implode Vals


# ------------------------------------------------------------
#
# Test if an array key/index is set (1) or not (0)
#

if [ ${DAT_ARRAY[${DAT_KEY}]+X} ]; then echo "1 key is set"; else echo "0 key not set"; fi;


# ------------------------------------------------------------
#
# Two Arrays Keyed with the same indices
#

unset ARR_CONTAINER_IDS; declare -A ARR_CONTAINER_IDS; # [Re-]Instantiate bash array
unset ARR_DOCKER_IMAGES; declare -A ARR_DOCKER_IMAGES; # [Re-]Instantiate bash array

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

	READ_TIMEOUT=20; read -p "Select: " -t ${READ_TIMEOUT} <'/dev/tty';
	if [ -z "${REPLY}" ]; then
		echo "Error: Response timed out after ${READ_TIMEOUT}s";
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

unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=("Item-One" "Item-One" "Item-Two" "Item-A" "Item-A" "Item-B");
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
echo "${DAT_ITEM}";
done;

# #  ^
# #  Methods have equivalent output
# #  v

unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-Two");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-B");
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
echo "------------------------------";
echo "${DAT_ITEM}";
done;

# #  ^
# #  Methods have equivalent output
# #  v

unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
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

unset DAT_ARRAY; declare -A DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=("Item-One" "Item-One" "Item-Two" "Item-A" "Item-A" "Item-B");
DAT_ARRAY_SORTED_NO_DUPES=($(echo "${DAT_ARRAY[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ';));
for DAT_ITEM in "${DAT_ARRAY_SORTED_NO_DUPES[@]}"; do
echo "${DAT_ITEM}";
done;

# -------------------------------------------------------------
#
#	Check an array for a given value
#

CONTAINS_ELEMENT(){ local X Y="$1";shift;for X;do [[ "$X" == "$Y" ]] && return 0;done;return 1; };

# Ex - Using CONTAINS_ELEMENT

TEST_ARRAY=("value 1" "value 2" "value 3");
CONTAINS_ELEMENT "value 1" "${TEST_ARRAY[@]}"; echo ${?};  # returns 0
CONTAINS_ELEMENT "value x" "${TEST_ARRAY[@]}"; echo ${?};  # returns 1


# -------------------------------------------------------------
#
#	Reference Arrays as variables whose variable-names are built from other arrays' string-values.
#	Then, combine all arrays and find unique items amongst their net result;
#

unset DAT_A_ARRAY; declare -a DAT_A_ARRAY; DAT_A_ARRAY=("Item-One" "Item-Two"); # [Re-]Instantiate bash array
unset DAT_B_ARRAY; declare -a DAT_B_ARRAY; DAT_B_ARRAY=("Item-A" "Item-B"); # [Re-]Instantiate bash array
unset DAT_C_ARRAY; declare -a DAT_C_ARRAY; DAT_C_ARRAY=("Item-B" "Item-One"); # [Re-]Instantiate bash array
unset DAT_D_ARRAY; declare -a DAT_D_ARRAY; DAT_D_ARRAY=("Item-B" "Item-C" "Item-Two" "Item-Two"); # [Re-]Instantiate bash array

unset ARRAY_LETTERS; declare -a ARRAY_LETTERS; ARRAY_LETTERS=("A" "B" "C" "D"); # [Re-]Instantiate bash array

echo -e "\n\n";

unset ALL_ITEMS_ARRAY; declare -a ALL_ITEMS_ARRAY; # [Re-]Instantiate bash array

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

unset ALL_ITEMS_SORTED_UNIQUE; ALL_ITEMS_SORTED_UNIQUE=($(echo "${ALL_ITEMS_ARRAY[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ';));

echo -e "\n\n";

echo "\$ALL_ITEMS_SORTED_UNIQUE=(${ALL_ITEMS_SORTED_UNIQUE[@]})";

echo -e "\n\n";

# -------------------------------------------------------------
#
# Citation(s)
#
#   serverfault.com  |  "Check if array is empty in Bash"  |  https://serverfault.com/a/477506
#
#   stackoverflow.com  |  "bash - Easiest way to check for an index or a key in an array? - Stack Overflow"  |  https://stackoverflow.com/a/13221491
#
#   stackoverflow.com  |  "Check if a Bash array contains a value - Stack Overflow"  |  https://stackoverflow.com/a/8574392
#
#   stackoverflow.com  |  "Loop through an array of strings in Bash?"  |  https://stackoverflow.com/a/8880633
#
#   stackoverflow.com  |  "Multidimensional associative arrays in Bash"  |  https://stackoverflow.com/a/6151190
#
#   www.cyberciti.biz  |  "How To Find BASH Shell Array Length ( number of elements ) - nixCraft"  |  https://www.cyberciti.biz/faq/finding-bash-shell-array-length-elements/
#
#   www.gnu.org  |  "Arrays (Bash Reference Manual)"  |  https://www.gnu.org/software/bash/manual/html_node/Arrays.html
#
#   www.linuxjournal.com  |  "Bash Associative Arrays | Linux Journal"  |  https://www.linuxjournal.com/content/bash-associative-arrays
#
# ------------------------------------------------------------