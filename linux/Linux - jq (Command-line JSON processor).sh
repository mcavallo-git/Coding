#!/bin/bash
# ------------------------------------------------------------
#
# Install jq
#
if [ $(which jq 2>'/dev/null' | wc -l;) -eq 0 ]; then
  echo "Downloading/Installing jq...";
  if [ "$(uname -s)" == "Linux" ] || [[ "${OSTYPE}" == linux-gnu* ]]; then
    # Install jq for Linux
    if [ $(which apt-get 1>'/dev/null' 2>&1; echo $?;) -eq 0 ]; then  # Distros: Debian, Ubuntu, etc.
      apt-get update -y; apt-get install -y "jq";
    elif [ $(which yum 1>'/dev/null' 2>&1; echo $?;) -eq 0 ]; then  # Distros: Fedora, Oracle Linux, Red Hat Enterprise Linux, CentOS, etc.
      curl -o "/usr/bin/jq" "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" && chmod 0755 "/usr/bin/jq";
    fi;
  elif [[ "${OSTYPE}" == "darwin"* ]]; then
    # Install jq for MacOS
    echo "Error - Need install logic for [ jq ] on MacOS environments";
  else
    # Install jq for Windows
    mkdir -p "${HOME}/bin";
    curl -L -o "${HOME}/bin/jq.exe" "https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe";
  fi;
  echo "";
  echo "which jq = [ $(which jq 2>'/dev/null';) ]";
  echo "";
fi;


# ------------------------------------------------------------
# jq - Check if a specific JSON property exists (or not)
#
if [[ 1 -eq 1 ]]; then
EXAMPLE_JSON='{"key1":"val1","key2":"val2","key3":{"key31":"val31","key32":"val32"}}';
echo "------------------------------";
echo "EXAMPLE_JSON = ${EXAMPLE_JSON}";
echo "------------------------------";
PROPERTY_KEY_TO_GET=".key3";
if [ "$(echo "${EXAMPLE_JSON}" | jq -r "${PROPERTY_KEY_TO_GET}";)" != "null" ]; then
echo "Info - JSON property verified to exist: \"${PROPERTY_KEY_TO_GET}\"";
else
echo "Error - JSON property not found: \"${PROPERTY_KEY_TO_GET}\"";
fi;
echo "------------------------------";
PROPERTY_KEY_TO_GET=".key4";
if [ "$(echo "${EXAMPLE_JSON}" | jq -r "${PROPERTY_KEY_TO_GET}";)" != "null" ]; then
echo "Info - JSON property verified to exist: \"${PROPERTY_KEY_TO_GET}\"";
else
echo "Error - JSON property not found: \"${PROPERTY_KEY_TO_GET}\"";
fi;
echo "------------------------------";
fi;


# ------------------------------------------------------------
# jq - Modify the value held by a specific JSON property
#
if [[ 1 -eq 1 ]]; then
EXAMPLE_JSON='{"key1":"val1","key2":"val2","key3":{"key31":"val31","key32":"val32"}}';
MODIFIED_JSON=$(echo "${EXAMPLE_JSON}" | jq '.key3.key31 = "replaced-value"';);
MODIFIED_JSON_COMPRESSED=$(echo "${MODIFIED_JSON}" | jq -c .;);
echo "------------------------------";
echo "EXAMPLE_JSON = ${EXAMPLE_JSON}";
echo "------------------------------";
echo "MODIFIED_JSON = ${MODIFIED_JSON}";
echo "------------------------------";
echo "MODIFIED_JSON_COMPRESSED = ${MODIFIED_JSON_COMPRESSED}";
echo "------------------------------";
fi;


# ------------------------------------------------------------
# jq - Convert a bash associative array to a JSON object
#
unset DAT_ARRAY; declare -A DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=(["Key A"]="Val One");
DAT_ARRAY+=(["Key B"]="Val Two");
DAT_ARRAY+=(["Key 100"]="100");
DAT_ARRAY+=(["Key 200"]="200");
JSON_OUTPUT=$(for i in "${!DAT_ARRAY[@]}"; do echo "$i"; echo "${DAT_ARRAY[$i]}"; done | jq -n -R 'reduce inputs as $i ({}; . + { ($i): (input|(tonumber? // .)) })');
JSON_COMPRESSED=$(echo ${JSON_OUTPUT} | jq -c .);
echo "\${JSON_OUTPUT} = ${JSON_OUTPUT}"; echo "\${JSON_COMPRESSED} = ${JSON_COMPRESSED}";


# ------------------------------------------------------------
# jq - Convert a bash indexed array (non-associative) to a JSON object
#
unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Val-1");
DAT_ARRAY+=("Val-2");
DAT_ARRAY+=("Val-3");
DAT_ARRAY+=("Val-4");
JSON_OUTPUT=$(printf '%s\n' "${DAT_ARRAY[@]}" | jq -R . | jq -s .);
JSON_COMPRESSED=$(echo ${JSON_OUTPUT} | jq -c .);
echo "\${JSON_OUTPUT} = ${JSON_OUTPUT}"; echo "\${JSON_COMPRESSED} = ${JSON_COMPRESSED}";


# ------------------------------------------------------------
# jq - Get the first 2 items in the "items" property's array (which is within/just-under the main JSON object)
#
JSON_INPUT=$(curl "https://ip-ranges.atlassian.com");
echo "${JSON_INPUT}" | jq '.items[0:2]';


# ------------------------------------------------------------
# jq - Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#
JSON_INPUT=$(curl "https://ip-ranges.atlassian.com");
echo "${JSON_INPUT}" | jq '.items[] | .cidr';


# ------------------------------------------------------------
# jq - Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#   |----> Slice off all double-quotes (prepping for output)
#
JSON_INPUT=$(curl "https://ip-ranges.atlassian.com");
echo "${JSON_INPUT}" | jq '.items[] | .cidr' | tr -d '"';


# ------------------------------------------------------------
# jq - Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#   |----> Slice off all double-quotes (prepping for output)
#   |-----> Wrap the jq call in a for-loop and add some string to the beginning/end of each line to prep it to-be-used-by as an NGINX IPv4 whitelist
#
for EACH_CIDR in $(curl -s "https://ip-ranges.atlassian.com" | jq '.items[] | .cidr' | tr -d '"' | sort); do echo "allow ${EACH_CIDR};"; done;


# ------------------------------------------------------------
# jq - Replace JSON Dynamically
#
cat "/etc/docker/daemon.json" | jq;
jq --arg SETPROP "local" '."log-driver" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "25m" '."log-opts"."max-size" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "1" '."log-opts"."max-file" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "false" '."log-opts"."compress" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
cat "/etc/docker/daemon.json" | jq;


# ------------------------------------------------------------
# jq - Search a JSON array for a specific value

if [ "1" == "1" ]; then
echo "------------------------------------------------------------";
CONTENTS_JSON="[\"refs/heads/dev\",\"refs/heads/main\",\"refs/heads/master\"]";
TEMP_JSON=$(mktemp);
echo -e "\n${CONTENTS_JSON}" > "${TEMP_JSON}";
echo -e "\nCreated temporary file \"${TEMP_JSON}\" with (JSON) contents: ${CONTENTS_JSON}";
echo -e "\n------------------------------------------------------------";
echo -e "\nTest 1.1 - jq 'index( \"refs/heads/dev\" )'..."; cat "${TEMP_JSON}" | jq 'index( "refs/heads/dev" )';
echo -e "\nTest 1.2 - jq 'index( \"refs/heads/main\" )'..."; cat "${TEMP_JSON}" | jq 'index( "refs/heads/main" )';
echo -e "\nTest 1.3 - jq 'index( \"refs/heads/master\" )'..."; cat "${TEMP_JSON}" | jq 'index( "refs/heads/master" )';
echo -e "\nTest 1.4 - jq 'index( \"refs/heads/invalid\" )'..."; cat "${TEMP_JSON}" | jq 'index( "refs/heads/invalid" )';
echo -e "\nTest 1.5 - jq 'index( \"invalid/dev\" )'..."; cat "${TEMP_JSON}" | jq 'index( "invalid/dev" )';
echo -e "\n------------------------------------------------------------";
echo -e "\nTest 2.1 - jq 'any(. == \"refs/heads/dev\" )'..."; cat "${TEMP_JSON}" | jq 'any(. == "refs/heads/dev")';
echo -e "\nTest 2.2 - jq 'any(. == \"refs/heads/main\" )'..."; cat "${TEMP_JSON}" | jq 'any(. == "refs/heads/main")';
echo -e "\nTest 2.3 - jq 'any(. == \"refs/heads/master\" )'..."; cat "${TEMP_JSON}" | jq 'any(. == "refs/heads/master")';
echo -e "\nTest 2.4 - jq 'any(. == \"refs/heads/invalid\" )'..."; cat "${TEMP_JSON}" | jq 'any(. == "refs/heads/invalid")';
echo -e "\nTest 2.5 - jq 'any(. == \"invalid/dev\" )'..."; cat "${TEMP_JSON}" | jq 'any(. == "invalid/dev")';
echo -e "\n------------------------------------------------------------";
echo -e "\nRemoving temporary file \"${TEMP_JSON}\"...";
rm -f "${TEMP_JSON}";
echo -e "\n------------------------------------------------------------";
fi;


# ------------------------------------------------------------
# jq - Example:  Find files named "appsettings.json" in target directory (Visual Studio Project) & perform replacements on each matching .json file via jq
#

if [[ 1 -eq 1 ]]; then
  #
  # Inputs variables (override with values relative to target deployment environment)
  AQMP_SERVICE_NAME="${AQMP_SERVICE_NAME:-Azure Service Bus}";  # "Azure Service Bus" or "RabbitMQ"
  HOST_SCHEME_FQDN="${HOST_SCHEME_FQDN:-https://example.com}";  # Endpoint URL ingested by the Kestrel Web Server for ASP.NET Core
  RABBITMQ_HOSTNAME="${RABBITMQ_HOSTNAME:-rabbitmq}";
  SERVICE_BUS_CONNECTION_STRING="${SERVICE_BUS_CONNECTION_STRING:-}";  # Azure Service Bus connection string
  SERVICE_BUS_NAME="${SERVICE_BUS_NAME:-azure-service-bus-name}";  # Resource Name of target Azure Service Bus to use
  SQL_SERVER_NAME="${SQL_SERVER_NAME:-azure-sql-server-name}";  # Resource Name of target Azure (PAAS) SQL Server to use
  SQL_DATABASE_NAME="${SQL_DATABASE_NAME:-database-name}";  # Resource Name of target Azure (PAAS) SQL Database to use
  #
  # Calculated variables (based off of inputs)
  SERVICE_BUS_URI="sb://${SERVICE_BUS_NAME}.servicebus.windows.net";  # Azure Service Bus endpoint URI
  SQL_CONNECTION_STRING="Server=Data Source=${SQL_SERVER_NAME};Initial Catalog=${SQL_DATABASE_NAME}";
  #
  # Find files named "appsettings.json" in target directory (Visual Studio Project)
  for EACH_FILE_TO_JQ in $(find "${FULLPATH_VS_SLN_DIRECTORY}" -type "f" -iname "appsettings.json";); do
    echo -e "EACH_FILE_TO_JQ = [ ${EACH_FILE_TO_JQ} ]";
    EACH_JSON_CONTENTS="$(cat "${EACH_FILE_TO_JQ}";)";
    UPDATED_JSON_CONTENTS="${EACH_JSON_CONTENTS}";
    #
    # jq - replace/set/update property [ .applicationUrl ]
    #
    PROPERTY_KEY_TO_GET=".applicationUrl";
    if [ "$(echo "${EACH_JSON_CONTENTS}" | jq -r "${PROPERTY_KEY_TO_GET}";)" != "null" ]; then
      PROPERTY_DESCRIPTION="Application URL/FQDN";
      PROPERTY_KEY_TO_SET="${PROPERTY_KEY_TO_GET}";
      PROPERTY_VAL_TO_SET="\"${HOST_SCHEME_FQDN}\"";
      UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${PROPERTY_KEY_TO_SET} |= ${PROPERTY_VAL_TO_SET}";);
      echo -e " (Updated) $(printf '%-35s' "$PROPERTY_DESCRIPTION";) ( ${PROPERTY_KEY_TO_SET} )";
    fi;
    #
    # jq - check-for/get property [ .Bus ]
    #
    PROPERTY_KEY_TO_GET=".Bus";
    if [ "$(echo "${EACH_JSON_CONTENTS}" | jq -r "${PROPERTY_KEY_TO_GET}";)" != "null" ]; then
      # Service Bus Update
      if [ "${AQMP_SERVICE_NAME}" == "Azure Service Bus" ]; then
        #
        # jq - replace/set/update property [ .Bus.ServiceBus.ConnectionString ]
        #
        PROPERTY_DESCRIPTION="Service Bus Connection String";
        PROPERTY_KEY_TO_SET=".Bus.ServiceBus.ConnectionString";
        PROPERTY_VAL_TO_SET="\"${SERVICE_BUS_CONNECTION_STRING}\"";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${PROPERTY_KEY_TO_SET} |= ${PROPERTY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$PROPERTY_DESCRIPTION";) ( ${PROPERTY_KEY_TO_SET} )";
        #
        # jq - replace/set/update property [ .Bus.ServiceBus.ServiceUri ]
        #
        PROPERTY_DESCRIPTION="Service Bus Service URI";
        PROPERTY_KEY_TO_SET=".Bus.ServiceBus.ServiceUri";
        PROPERTY_VAL_TO_SET="\"${SERVICE_BUS_URI}\"";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${PROPERTY_KEY_TO_SET} |= ${PROPERTY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$PROPERTY_DESCRIPTION";) ( ${PROPERTY_KEY_TO_SET} )";
      fi;
      # RabbitMQ Update/Remove
      if [ "${AQMP_SERVICE_NAME}" == "RabbitMQ" ]; then
        #
        # jq - replace/set/update property [ .Bus.RabbitMq.Host ]
        #
        PROPERTY_DESCRIPTION="RabbitMQ Hostname";
        PROPERTY_KEY_TO_SET=".Bus.RabbitMq.Host";
        PROPERTY_VAL_TO_SET="\"${RABBITMQ_HOSTNAME}\"";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${PROPERTY_KEY_TO_SET} |= ${PROPERTY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$PROPERTY_DESCRIPTION";) ( ${PROPERTY_KEY_TO_SET} )";
      else
        #
        # jq - delete property [ .Bus.RabbitMq ]
        #
        PROPERTY_DESCRIPTION="Remove RabbitMQ from JSON";
        PROPERTY_KEY_TO_SET=".Bus";
        PROPERTY_VAL_TO_SET="del(.RabbitMq)";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${PROPERTY_KEY_TO_SET} |= ${PROPERTY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$PROPERTY_DESCRIPTION";) ( ${PROPERTY_KEY_TO_SET} )";
      fi;
    fi;
    #
    # jq - replace/set/update property [ .SqlServer.FilesDbConnection ]
    #
    PROPERTY_KEY_TO_GET=".SqlServer.FilesDbConnection";
    if [ "$(echo "${EACH_JSON_CONTENTS}" | jq -r "${PROPERTY_KEY_TO_GET}";)" != "null" ]; then
      PROPERTY_DESCRIPTION="SQL Server Connection String";
      PROPERTY_KEY_TO_SET="${PROPERTY_KEY_TO_GET}";
      PROPERTY_VAL_TO_SET="\"${SQL_CONNECTION_STRING}\"";
      UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${PROPERTY_KEY_TO_SET} |= ${PROPERTY_VAL_TO_SET}";);
      echo -e " (Updated) $(printf '%-35s' "$PROPERTY_DESCRIPTION";) ( ${PROPERTY_KEY_TO_SET} )";
    fi;
    if [ "${UPDATED_JSON_CONTENTS}" == "${EACH_JSON_CONTENTS}" ]; then
      # No changes required - Do not update target [ appsettings.json ] file
      echo -e " (No Changes) File contents are already up-to-date""\n";
      echo "${EACH_JSON_CONTENTS}" | jq;
    else
      # Changes required - Update target [ appsettings.json ] file
      echo "${EACH_JSON_CONTENTS}" | jq;
      echo "";
      echo "||| ↑ ↑ ↑ ↑ ↑ ↑ ||| ↓ ↓ ↓ ↓ ↓ ↓ |||";
      echo "||| ↑ ↑ ↑ BEFORE ↑ ↑ ↑ ||| ↓ ↓ ↓ AFTER ↓ ↓ ↓ |||";
      echo "||| ↑ ↑ ↑ WORKAROUND(S) ↑ ↑ ↑ ||| ↓ ↓ ↓ WORKAROUND(S) ↓ ↓ ↓ |||";
      echo "||| ↑ ↑ ↑ ↑ ↑ ↑ ||| ↓ ↓ ↓ ↓ ↓ ↓ |||";
      echo "";
      echo "${UPDATED_JSON_CONTENTS}" | jq;
      echo "";
      cp --force --verbose "${EACH_FILE_TO_JQ}" "${EACH_FILE_TO_JQ}.bak";
      echo -e "${UPDATED_JSON_CONTENTS}" | jq > "${EACH_FILE_TO_JQ}";
    fi;
  done;
fi;


# ------------------------------------------------------------
# Citation(s)
#
#   github.com  |  "Releases · stedolan/jq · GitHub"  |  https://github.com/stedolan/jq/releases
#
#   github.com  |  "GitHub - stedolan/jq: Command-line JSON processor"  |  https://github.com/stedolan/jq/
#
#   github.io  |  "[jq] Tutorial"  |  https://stedolan.github.io/jq/tutorial/
#
#   serverfault.com  |  "How to install jq on RHEL6.5 - Server Fault"  |  https://serverfault.com/a/768061
#
#   stackoverflow.com  |  "bash - Add new element to existing JSON array with jq - Stack Overflow"  |  https://stackoverflow.com/a/42248841
#
#   stackoverflow.com  |  "bash - jq returning null as string if the json is empty - Stack Overflow"  |  https://stackoverflow.com/a/53135202
#
#   stackoverflow.com  |  "bash - Modify a key-value in a json using jq - Stack Overflow"  |  https://stackoverflow.com/a/42717073
#
#   stackoverflow.com  |  "Constructing a json hash from a bash associative array - Stack Overflow"  |  https://stackoverflow.com/a/44792751
#
#   stackoverflow.com  |  "How to format a bash array as a JSON array"  |  https://stackoverflow.com/a/26809318
#
#   stackoverflow.com  |  "json - How to check if element exists in array with jq - Stack Overflow"  |  https://stackoverflow.com/a/43269105
#
# ------------------------------------------------------------