#!/bin/bash
# ------------------------------------------------------------
# Linux - basename, dirname (filename, file extension, directory path)
# ------------------------------------------------------------

if [ 1 -eq 1 ]; then

  echo "";

  FULLPATH="${HOME}/example.txt";
  echo "fullpath:                \"${FULLPATH}\"";

  touch "${FULLPATH}";

  # realpath
  REALPATH=$(realpath "${FULLPATH}";);
  echo "realpath:                \"${REALPATH}\"";

  # ------------------------------

  echo "";

  # basename
  BASENAME=$(basename "${FULLPATH}";);
  echo "basename:                \"${BASENAME}\"";

  # basename w/o extension
  BASENAME_NO_EXTENSION=$(basename "${FULLPATH}" | cut -d. -f1;);
  echo "basename w/o extension:  \"${BASENAME_NO_EXTENSION}\"";

  # extension only
  EXTENSION=$(basename "${FULLPATH}" | cut -d. -f2);
  echo "extension:               \"${EXTENSION}\"";

  # ------------------------------

  echo "";

  # dirname
  DIRNAME=$(dirname "${FULLPATH}";);
  echo "dirname:                 \"${DIRNAME}\"";

  # directory name
  DIR_BASENAME=$(basename "$(dirname "${FULLPATH}";)";);
  echo "dir basename:            \"${DIR_BASENAME}\"";

  # ------------------------------

  rm "${FULLPATH}";

  echo "";

fi;

# ------------------------------------------------------------