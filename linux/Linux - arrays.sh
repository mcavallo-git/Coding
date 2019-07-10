#!/bin/bash
#
# Linux - Arrays
#
# -------------------------------------------------------------
#
# Create & walk-through an array
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
# 	stackoverflow.com  |  "Loop through an array of strings in Bash?"  |  https://stackoverflow.com/a/8880633
#
# ------------------------------------------------------------