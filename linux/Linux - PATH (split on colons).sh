#!/bin/bash

# Option 1 (Quick Inspection)
echo "${PATH//:/
}";

# Option 2 (Through parsing & per-item functionality)
ROLLBACK_IFS="${IFS}"; IFS=':' read -ra PATHS_ARR <<< "$PATH"; # Set the global for-loop delimiter
for EACH_PATH in "${PATHS_ARR[@]}"; do
	echo "------------------------------------------------------------";
	echo "${EACH_PATH}";
done;
IFS="${ROLLBACK_IFS}"; # Restore the global for-loop delimiter
