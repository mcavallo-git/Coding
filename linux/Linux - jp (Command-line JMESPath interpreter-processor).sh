#!/bin/bash
# ------------------------------------------------------------
#
# Install jp
#

if [[ 1 -eq 1 ]]; then
  EXIT_CODE=0;
  # ------------------------------
  #
  # Override these variables' default values using environment variables
  #
  GITHUB_OWNER="${GITHUB_OWNER:-jmespath}";
  GITHUB_REPO="${GITHUB_REPO:-jp}";
  VERSION_CLI="${VERSION_CLI:---version 2>'/dev/null' | rev | cut -d' ' -f1 | rev}";
  FULLPATH_LOCAL_PKG="${FULLPATH_LOCAL_PKG}";
  # ------------------------------
  INSTALL_PKG=1;
  # Determine OS and processor architecture
  OS_NAME="";
  if [ "$(uname -s)" == "Linux" ] || [[ "${OSTYPE}" == "linux"* ]]; then
    # Install pkg for Linux
    FULLPATH_LOCAL_PKG="/usr/bin/${GITHUB_REPO}";
    OS_NAME="linux";
    if [[ -n "$(command -v dpkg 2>'/dev/null';)" ]]; then
      PROCESSOR_ARCH="$(dpkg --print-architecture;)";
    fi;
  elif [[ "${OSTYPE}" == "darwin"* ]]; then
    # Install pkg for MacOS
    FULLPATH_LOCAL_PKG="/usr/bin/${GITHUB_REPO}";
    OS_NAME="darwin";
  else
    # Install pkg for Windows
    FULLPATH_LOCAL_PKG="${HOME}/bin/${GITHUB_REPO}.exe";
    OS_NAME="windows";
  fi;
  PKG_NAME="$(basename "${FULLPATH_LOCAL_PKG}")";
  # ------------------------------
  # Get package's latest release version
  OS_ARCH="${OS_NAME}-${PROCESSOR_ARCH:-amd64}";
  PKG_RELEASES_URL="https://github.com/${GITHUB_OWNER}/${GITHUB_REPO}/releases";
  RELEASE_INFO=$(curl -sL "${PKG_RELEASES_URL}" | grep '<a href' | grep "${GITHUB_OWNER}/${GITHUB_REPO}/releases/download" | grep "${OS_ARCH}" | head -n 1 | sed -rne "s/^.+<a href=\"((https:\\/\\/github\.com)?\\/${GITHUB_OWNER//\//\\\/}\\/${GITHUB_REPO//\//\\\/}\/releases\/download\/([^\"\\/]+)\/([^\"-]+-${OS_ARCH}[^\"]*))\".+$/\1\n\3/pi";);
  if [[ -z "${RELEASE_INFO}" ]]; then
    echo "";
    echo "Error:  No data returned from URL [ ${PKG_RELEASES_URL} ] while attempting to obtain latest release info";
  else
    RELEASE_URL="$(if [[ "$(echo "${RELEASE_INFO}" | head -n 1 | grep 'https://github.com' | wc -l;)" -eq 0 ]]; then echo -n "https://github.com"; fi;)$(echo -n "${RELEASE_INFO}" | head -n 1)";
    RELEASE_FILENAME="$(echo "${RELEASE_URL}" | rev | cut -d'/' -f1 | rev;)";
    RELEASE_VERSION="$(echo "${RELEASE_INFO}" | tail -n 1;)";
    # Handle scenarios where the package is already installed
    if [[ -f "${FULLPATH_LOCAL_PKG}" ]]; then
      # Package is already installed
      # Get the locally installed package's version
      LOCAL_VERSION="$(eval "${FULLPATH_LOCAL_PKG} ${VERSION_CLI}";)";
      if [[ -z "${LOCAL_VERSION}" ]] ; then
        # Installed package's version was unable to be obtained - remove it
        INSTALL_PKG=1;
        echo "";
        echo "Warning:  Unable to obtain version from file \"${FULLPATH_LOCAL_PKG}\" - Removing...";
        rm -rfv "${FULLPATH_LOCAL_PKG}";
      elif [[ -n "${LOCAL_VERSION}" ]] && [[ -n "${RELEASE_VERSION}" ]] && [[ "${LOCAL_VERSION}" == "${RELEASE_VERSION}" ]]; then
        # Installed version matches latest version
        INSTALL_PKG=0;
        echo "";
        echo "Info:  Package \"${PKG_NAME}\" is already installed and up-to-date with the latest version [ ${RELEASE_VERSION} ]";
      else
        # Installed version differs from latest version
        READ_TIMEOUT=60;
        USER_RESPONSE="";
        echo "";
        read -p "Info:  Do you want to update package \"${PKG_NAME}\" from version [ ${LOCAL_VERSION} ] to version [ ${RELEASE_VERSION} ]?  (press 'y' to confirm)  " -a USER_RESPONSE -n 1 -t ${READ_TIMEOUT} <'/dev/tty'; EXIT_CODE=${?};
        echo "";
        if [[ "${USER_RESPONSE}" =~ ^[Yy]$ ]]; then
          INSTALL_PKG=1;
        else
          INSTALL_PKG=0;
        fi;
      fi;
    fi;
  fi;
  # Download/Install the package
  if [[ "${INSTALL_PKG}" -eq 1 ]]; then
    if [[ -n "${RELEASE_URL}" ]]; then
      echo "";
      echo "Info:  Downloading/Installing package \"${PKG_NAME}\" to local filepath \"${FULLPATH_LOCAL_PKG}\"...";
      if [[ ! -d "${FULLPATH_LOCAL_PKG}" ]]; then
        mkdir -p "$(dirname "${FULLPATH_LOCAL_PKG}";)";
      fi;
      # Download & install the package
      curl -sL -o "${FULLPATH_LOCAL_PKG}" "${RELEASE_URL}";
      chmod 0755 "${FULLPATH_LOCAL_PKG}";
    fi;
    LOCAL_VERSION="$(eval "${FULLPATH_LOCAL_PKG} ${VERSION_CLI}";)";
    if [[ -z "${LOCAL_VERSION}" ]] ; then
      # Fallback install method(s)
      echo "";
      echo "Info:  Installing package \"${PKG_NAME}\" (via apt)...";
      if [[ -n "$(command -v apt 2>'/dev/null';)" ]]; then  # Distros: Debian, Ubuntu, etc.
        apt-get -y update; apt-get -y install "jp";
      fi;
    fi;
  fi;
  # Get the locally installed package's version
  LOCAL_VERSION="$(eval "${FULLPATH_LOCAL_PKG} ${VERSION_CLI}";)";
  if [[ -n "${LOCAL_VERSION}" ]] ; then
    # Package installed successfully
    echo ""
    echo "Info:  Package \"${PKG_NAME}\" exists locally (w/ version [ ${LOCAL_VERSION} ])";
  else
    # Package install failed
    echo "";
    echo "Error:  Package \"${PKG_NAME}\" not found locally";
    EXIT_CODE=1;
  fi;
fi;


# ------------------------------------------------------------
#
# jp - get [ one (1) key's value ]
#
# echo '{"id":"1","name":"obj1","value":"val1"}' | jp -r '.name';


#
# jp - get [ one (1) key's value ] from [ each object in a top-level JSON array ]
#
# JP_QUERY='.[].name';
# JSON='[{"id":"1","name":"obj1","value":"val1"},{"id":"2","name":"obj2","value":"val2"}]';
# echo "${JSON}" | jp -r "${JP_QUERY}";


# ------------------------------------------------------------
#
# jp - get [ multiple (N) keys' values ]
#
# echo '{"id":"1","name":"obj1","value":"val1"}' | jp -r '{name:.name,value:.value}';


#
# jp - get [ multiple (N) keys' values ] from [ each object in a top-level JSON array ]
#
# JP_QUERY='.[]|{value:.value,name:.name}';
# JSON='[{"id":"1","name":"obj1","value":"val1"},{"id":"2","name":"obj2","value":"val2"}]';
# echo "${JSON}" | jp "${JP_QUERY}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "GitHub - jmespath/jp: Command line interface to JMESPath - http://jmespath.org"  |  https://github.com/jmespath/jp
#
#   www.devmanuals.net  |  "How to install jp on Ubuntu 20.04 (Focal Fossa)?"  |  https://www.devmanuals.net/install/ubuntu/ubuntu-20-04-focal-fossa/installing-jp-on-ubuntu20-04.html
#
# ------------------------------------------------------------