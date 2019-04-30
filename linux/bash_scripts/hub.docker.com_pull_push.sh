
shopt -s nocasematch; # nocasematch: Bash matches patterns in a case-insensitive fashion when performing matching while executing case or [[ conditional commands.

ERRORS_FOUND=0;

if [ ! -n "${1}" ]; then echo   "Error in ${0}: Parameter #1 empty/unset (ACTION_PULL_OR_PUSH) "; ERRORS_FOUND=1;  else ACTION_PULL_OR_PUSH="${1}"; fi;
if [ ! -n "${2}" ]; then echo   "Error in ${0}: Parameter #2 empty/unset (LOCAL_IMAGE)";          ERRORS_FOUND=1;  else LOCAL_IMAGE="${2}";         fi;
if [ ! -n "${3}" ]; then echo   "Error in ${0}: Parameter #3 empty/unset (DOCKERHUB_IMAGE) ";     ERRORS_FOUND=1;  else DOCKERHUB_IMAGE="${3}";     fi;
if [ ! -n "${4}" ]; then echo "Warning in ${0}: Parameter #4 empty/unset (DOCKERHUB_USER)";                        else DOCKERHUB_USER="${4}";      fi;
if [ ! -n "${5}" ]; then echo "Warning in ${0}: Parameter #5 empty/unset (DOCKERHUB_PASS)";                        else DOCKERHUB_PASS="${5}";      fi;
if [ ! -n "${6}" ]; then echo "Warning in ${0}: Parameter #6 empty/unset (LATEST_IMAGE_REFERENCE)";                else LATEST_IMAGE_REFERENCE="${6}";      fi;

if [[ "${ERRORS_FOUND}" == "0" ]]; then

	NEW_TAG_PUSHED="";
	
	DOCKERHUB_FULL_PATH="${DOCKERHUB_USER}/${DOCKERHUB_IMAGE}";

	# Kill any pre-existing connections to https://hub.docker.com by forcing a logout
	echo "";
	echo "Calling [docker logout]...     ($(date +'%D  %r'))";
	docker logout;
	
	# Login to https://hub.docker.com
	echo "";
	echo "Calling [docker login -u=\"${DOCKERHUB_USER}\" -p=\"...hidden...\"]...     ($(date +'%D  %r'))";
	docker login -u="${DOCKERHUB_USER}" -p="${DOCKERHUB_PASS}";
	ERRORS_FOUND=$?;

	if [[ "${ERRORS_FOUND}" == "0" ]]; then
		if [[ "${ACTION_PULL_OR_PUSH}" == "pull" ]]; then #/\/===--    PULL IMAGE FROM [ https://hub.docker.com ]    --===\/\#
			
			echo "Calling [docker pull \"${DOCKERHUB_FULL_PATH}\"]...     ($(date +'%D  %r'))";
			docker pull "${DOCKERHUB_FULL_PATH}";

		elif [[ "${ACTION_PULL_OR_PUSH}" == "push" ]]; then #/\/===--    PUSH IMAGE TO [ https://hub.docker.com ]    --===\/\#
			
			# Local images remove periods from their names, but keep them in everywhere else..? :(
			LOCAL_IMAGE_NOPERIODS=${LOCAL_IMAGE//[.]/};
			
			echo "Calling [docker tag \"${LOCAL_IMAGE_NOPERIODS}\" \"${DOCKERHUB_FULL_PATH}\"]...     ($(date +'%D  %r'))";
			docker tag "${LOCAL_IMAGE_NOPERIODS}" "${DOCKERHUB_FULL_PATH}";
			
			echo "Calling [docker push \"${DOCKERHUB_FULL_PATH}\"]...     ($(date +'%D  %r'))";
			docker push "${DOCKERHUB_FULL_PATH}";

		else
			ERRORS_FOUND=1; echo "Error in ${0}: Parameter #1 (ACTION_PULL_OR_PUSH) must be either 'pull' or 'push', received '${ACTION_PULL_OR_PUSH}'";

		fi;
		# Logout from https://hub.docker.com
		echo "";
		echo "Calling [docker logout]...     ($(date +'%D  %r'))";
		docker logout;
			
	fi;

fi;

exit ${ERRORS_FOUND};
