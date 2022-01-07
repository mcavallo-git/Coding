#!/bin/bash
# ------------------------------------------------------------
# Linux - tar (using czf=[compress files, directories into an archive], -zxf=[unpack .tar.gz archives])
# ------------------------------------------------------------
#
# tar czf
#  |-->  Compress files/directories into a '.tar.gz' archive
#  |-->  Unpack/Decompress files/directories from a '.tar.gz' archive
#

# .tar.gz  -  COMPRESS  (general syntax)
tar czf "${ARCHIVE_FILEPATH}" "${DIR_TO_COMPRESS_1}" "${DIR_TO_COMPRESS_2}";


# .tar.gz  -  UNPACK/DECOMPRESS  (general syntax)
tar -zxf "${ARCHIVE_FILEPATH}" --one-top-level=${DIR_TO_UNPACK_INTO};


# Example - COMPRESS --THEN-> DECOMPRESS
if [[ 1 -eq 1 ]]; then
ARCHIVE_FILEPATH="${HOME}/archive.tar.gz";
TMP_DIR_TO_COMP="/tmp/${PKG_NAME}_$(date +'%Y%m%d_%H%M%S')";
DIR_TO_COMPRESS_1="${TMP_DIR_TO_COMP}-1"; mkdir -pv "${DIR_TO_COMPRESS_1}";  # create mock directory to compress
DIR_TO_COMPRESS_2="${TMP_DIR_TO_COMP}-2"; mkdir -pv "${DIR_TO_COMPRESS_2}";  # create mock directory to compress
touch "${DIR_TO_COMPRESS_1}/a"; touch "${DIR_TO_COMPRESS_1}/b"; touch "${DIR_TO_COMPRESS_1}/c";  # create mock files to compress
touch "${DIR_TO_COMPRESS_2}/a"; touch "${DIR_TO_COMPRESS_2}/b"; touch "${DIR_TO_COMPRESS_2}/c";  # create mock files to compress
# ------------------------------
# Compress target files/directories into a given archive filepath
echo -e "\n\nCompressing directories \"${DIR_TO_COMPRESS_1}\" and \"${DIR_TO_COMPRESS_2}\" into archive \"${ARCHIVE_FILEPATH}\"...";
tar czf "${ARCHIVE_FILEPATH}" "${DIR_TO_COMPRESS_1}" "${DIR_TO_COMPRESS_2}";
echo "";
# ------------------------------
ls -al "${ARCHIVE_FILEPATH}";
# ------------------------------
# Unpack target archive into a given directory
DIR_TO_UNPACK_INTO="${HOME}/unpacked_$(date +'%Y%m%d_%H%M%S')"; mkdir -pv "${DIR_TO_UNPACK_INTO}";  # create directory to unpack into
echo -e "\n\nUnpacking archive \"${ARCHIVE_FILEPATH}\" into directory \"${DIR_TO_UNPACK_INTO}\"...";
tar -vzxf "${ARCHIVE_FILEPATH}" --one-top-level=${DIR_TO_UNPACK_INTO};
echo "";
# ------------------------------
mv -vf "${ARCHIVE_FILEPATH}" "${DIR_TO_UNPACK_INTO}/$(basename "${ARCHIVE_FILEPATH}")";
cd "${DIR_TO_UNPACK_INTO}";
echo -e "\n\nFinding all files under filepath \"${DIR_TO_UNPACK_INTO}\"...";
find "${DIR_TO_UNPACK_INTO}/"*;
echo "";
echo -e "\nCleanup leftover files";
rm -rfv "${ARCHIVE_FILEPATH}";
rm -rfv "${DIR_TO_COMPRESS_1}";
rm -rfv "${DIR_TO_COMPRESS_2}";
rm -rfv "${DIR_TO_UNPACK_INTO}";
echo "";
fi;


# ------------------------------------------------------------
#
# tar -zxf
#  |-->  Unpack/Decompress target '.tar.gz' archive
#


# Unpack an archive - outputs to CURRENT directory
mkdir "${HOME}/unpacked";
cd "${HOME}/unpacked";
tar -zxf "${HOME}/archive.tar.gz";


# Unpack an archive - outputs to TARGET directory
mkdir "${HOME}/unpacked";
cd "${HOME}";
tar -zxf "${HOME}/archive.tar.gz" --one-top-level=${HOME}/unpacked;


# ------------------------------------------------------------
#
# tar -zxf
#  |--> Robust(ish) example
#

if [[ 1 -eq 1 ]]; then
  echo "";
  echo -n "Info:  Creating temporary workspace:  ";
  TMP_DIR="/tmp/${PKG_NAME}-$(date +'%Y%m%d_%H%M%S')"; mkdir -pv "${TMP_DIR}";
  # Download the package
  FULLPATH_LOCAL_PKG="${HOME}/bin"; mkdir -p "${FULLPATH_LOCAL_PKG}";
  PKG_NAME="flux";
  LATEST_URL="https://github.com/fluxcd/flux2/releases/download/v0.24.1/flux_0.24.1_linux_amd64.tar.gz";
  LATEST_VERSION="v0.24.1";
  FULLPATH_CURLED_PKG="${TMP_DIR}/flux_0.24.1_linux_amd64.tar.gz";
  echo "";
  echo "Info:  Downloading & installing package \"${PKG_NAME}\"...";
  echo "        |--> Remote URL:  ${LATEST_URL}";
  echo "        |--> Local Filepath:  ${FULLPATH_CURLED_PKG}";
  curl -sL -o "${FULLPATH_CURLED_PKG}" "${LATEST_URL}";
  if [[ "${FULLPATH_CURLED_PKG}" == *.tar.gz  ]]; then
    echo "";
    echo -n "Info:  Unpacking .tar.gz archive:  ";
    FULLPATH_UNPACKED="${TMP_DIR}/$(tar -zxvf "${FULLPATH_CURLED_PKG}" --one-top-level=${TMP_DIR};)";
    FULLPATH_CURLED_PKG="${FULLPATH_CURLED_PKG//.tar.gz/}";
    mv -fv "${FULLPATH_UNPACKED}" "${FULLPATH_CURLED_PKG}";
  fi;
  # Set file permissions on the downloaded package
  echo "";
  echo -n "Info:  Setting execution bit for package binary:  ";
  chmod -v +x "${FULLPATH_CURLED_PKG}";  # chmod -v "0755" "${FULLPATH_CURLED_PKG}";
  if [[ "${FULLPATH_CURLED_PKG}" != "${FULLPATH_LOCAL_PKG}-${LATEST_VERSION}" ]]; then
    # Version-stamp the downloaded package
    echo "";
    echo -n "Info:  Applying version stamp to package binary:  ";
    mv -fv "${FULLPATH_CURLED_PKG}" "${FULLPATH_LOCAL_PKG}-${LATEST_VERSION}";
  fi;
  # Create commands to this package to redirect (via symbolic link) to this version-stamped package
  echo "";
  echo -n "Info:  Creating symbolic link for package binary:  ";
  ln -sfv "${FULLPATH_LOCAL_PKG}-${LATEST_VERSION}" "${FULLPATH_LOCAL_PKG}";
  # Clean up temporary working directory
  echo "";
  echo -n "Info:  Cleaning up temporary workspace:  ";
  rm -rfv "${TMP_DIR}";
  # Show output file
  echo "";
  echo -n "Info:  Showing binary file:  ";
  ls -al "$(realpath "${FULLPATH_CURLED_PKG}";)";
fi;


# ------------------------------------------------------------