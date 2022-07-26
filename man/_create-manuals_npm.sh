if [[ 1 -eq 1 ]]; then

  # ${REPOS_DIR}/Coding/man/_create-manuals_npm.sh

  COMMAND="npm";

  MANFILE="$(realpath "${HOME}/man/${COMMAND}.man";)";

  # ------------------------------

  unset COMMANDS_ARRAY; declare -a COMMANDS_ARRAY; # [Re-]Instantiate bash array
  COMMANDS_ARRAY+=("${COMMAND}");
  COMMANDS_ARRAY+=("${COMMAND} access");
  COMMANDS_ARRAY+=("${COMMAND} adduser");
  COMMANDS_ARRAY+=("${COMMAND} audit");
  COMMANDS_ARRAY+=("${COMMAND} bin");
  COMMANDS_ARRAY+=("${COMMAND} bugs");
  COMMANDS_ARRAY+=("${COMMAND} cache");
  COMMANDS_ARRAY+=("${COMMAND} ci");
  COMMANDS_ARRAY+=("${COMMAND} completion");
  COMMANDS_ARRAY+=("${COMMAND} config");
  COMMANDS_ARRAY+=("${COMMAND} dedupe");
  COMMANDS_ARRAY+=("${COMMAND} deprecate");
  COMMANDS_ARRAY+=("${COMMAND} diff");
  COMMANDS_ARRAY+=("${COMMAND} dist-tag");
  COMMANDS_ARRAY+=("${COMMAND} docs");
  COMMANDS_ARRAY+=("${COMMAND} doctor");
  COMMANDS_ARRAY+=("${COMMAND} edit");
  COMMANDS_ARRAY+=("${COMMAND} exec");
  COMMANDS_ARRAY+=("${COMMAND} explain");
  COMMANDS_ARRAY+=("${COMMAND} explore");
  COMMANDS_ARRAY+=("${COMMAND} find-dupes");
  COMMANDS_ARRAY+=("${COMMAND} fund");
  COMMANDS_ARRAY+=("${COMMAND} get");
  COMMANDS_ARRAY+=("${COMMAND} help");
  COMMANDS_ARRAY+=("${COMMAND} hook");
  COMMANDS_ARRAY+=("${COMMAND} init");
  COMMANDS_ARRAY+=("${COMMAND} install");
  COMMANDS_ARRAY+=("${COMMAND} install-ci-test");
  COMMANDS_ARRAY+=("${COMMAND} install-test");
  COMMANDS_ARRAY+=("${COMMAND} link");
  COMMANDS_ARRAY+=("${COMMAND} ll");
  COMMANDS_ARRAY+=("${COMMAND} login");
  COMMANDS_ARRAY+=("${COMMAND} logout");
  COMMANDS_ARRAY+=("${COMMAND} ls");
  COMMANDS_ARRAY+=("${COMMAND} org");
  COMMANDS_ARRAY+=("${COMMAND} outdated");
  COMMANDS_ARRAY+=("${COMMAND} owner");
  COMMANDS_ARRAY+=("${COMMAND} pack");
  COMMANDS_ARRAY+=("${COMMAND} ping");
  COMMANDS_ARRAY+=("${COMMAND} pkg");
  COMMANDS_ARRAY+=("${COMMAND} prefix");
  COMMANDS_ARRAY+=("${COMMAND} profile");
  COMMANDS_ARRAY+=("${COMMAND} prune");
  COMMANDS_ARRAY+=("${COMMAND} publish");
  COMMANDS_ARRAY+=("${COMMAND} rebuild");
  COMMANDS_ARRAY+=("${COMMAND} repo");
  COMMANDS_ARRAY+=("${COMMAND} restart");
  COMMANDS_ARRAY+=("${COMMAND} root");
  COMMANDS_ARRAY+=("${COMMAND} run-script");
  COMMANDS_ARRAY+=("${COMMAND} search");
  COMMANDS_ARRAY+=("${COMMAND} set");
  COMMANDS_ARRAY+=("${COMMAND} set-script");
  COMMANDS_ARRAY+=("${COMMAND} shrinkwrap");
  COMMANDS_ARRAY+=("${COMMAND} star");
  COMMANDS_ARRAY+=("${COMMAND} stars");
  COMMANDS_ARRAY+=("${COMMAND} start");
  COMMANDS_ARRAY+=("${COMMAND} stop");
  COMMANDS_ARRAY+=("${COMMAND} team");
  COMMANDS_ARRAY+=("${COMMAND} test");
  COMMANDS_ARRAY+=("${COMMAND} token");
  COMMANDS_ARRAY+=("${COMMAND} uninstall");
  COMMANDS_ARRAY+=("${COMMAND} unpublish");
  COMMANDS_ARRAY+=("${COMMAND} unstar");
  COMMANDS_ARRAY+=("${COMMAND} update");
  COMMANDS_ARRAY+=("${COMMAND} version");
  COMMANDS_ARRAY+=("${COMMAND} view");
  COMMANDS_ARRAY+=("${COMMAND} whoami");

  # ------------------------------

  if [[ -f "${MANFILE}" ]]; then
    rm -fv "${MANFILE}";
  fi;

  for EACH_COMMAND in "${COMMANDS_ARRAY[@]}"; do
    # ------------------------------
    # [command] --help
    EACH_EVAL="${EACH_COMMAND} --help 2>&1";
    echo "------------------------------------------------------------" >> "${MANFILE}";
    echo "[ ${EACH_EVAL} ]" >> "${MANFILE}";
    eval " ${EACH_EVAL}" >> "${MANFILE}";
    echo "" >> "${MANFILE}";
    echo "EACH_EVAL=[${EACH_EVAL}]";
    # ------------------------------
    # man [command]
    EACH_EVAL="man ${EACH_COMMAND} 2>&1";
    echo "------------------------------" >> "${MANFILE}";
    echo "[ ${EACH_EVAL} ]" >> "${MANFILE}";
    eval " ${EACH_EVAL}" >> "${MANFILE}";
    echo "" >> "${MANFILE}";
    echo "EACH_EVAL=[${EACH_EVAL}]";
    # ------------------------------
  done;

  echo "MANFILE=[${MANFILE}]";

fi;