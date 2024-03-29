#!/bin/bash
# ------------------------------------------------------------
# Linux - jq (command-line JSON interpreter-processor for [ JSON query language ])
# ------------------------------------------------------------
#
# jq - install
#
curl -H 'Cache-Control: no-cache' -s "https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/main/usr/local/sbin/install_jq?t=$(date +'%s.%N')" | bash;


# ------------------------------------------------------------
#
# jq - get [ one (1) key's value ]
#
echo '{"id":"1","name":"obj1","value":"val1"}' | jq -r '.name';


#
# jq - get [ one (1) key's value ] from [ each object in a top-level JSON array ]
#
JQ_QUERY='.[].name';
JSON='[{"id":"1","name":"obj1","value":"val1"},{"id":"2","name":"obj2","value":"val2"}]';
echo "${JSON}" | jq -r "${JQ_QUERY}";


# ------------------------------------------------------------
#
# jq - get [ multiple (N) keys' values ]
#
echo '{"id":"1","name":"obj1","value":"val1"}' | jq -r '{name:.name,value:.value}';


#
# jq - get [ multiple (N) keys' values ] from [ each object in a top-level JSON array ]
#
JQ_QUERY='.[]|{value:.value,name:.name}';
JSON='[{"id":"1","name":"obj1","value":"val1"},{"id":"2","name":"obj2","value":"val2"}]';
echo "${JSON}" | jq "${JQ_QUERY}";


# ------------------------------------------------------------
#
# jq - set/replace JSON property values
#

# Ex 1 - jq set/replace
echo "{}" | jq -c --arg SETPROP "value" '."key" = $SETPROP';
# Output:  {"key":"value"}


# Ex 2 - jq set/replace (multiple properties)
echo "{}" | jq -c --arg SETPROP1 "value1" --arg SETPROP2 "value2" '."key1" = $SETPROP1 | ."key2" = $SETPROP2';
# Output:  {"key1":"value1","key2":"value2"}


# Ex 3 - jq set/replace (nested properties)
echo "{}" | jq -c --arg SETPROP "value" '."key"."key-nested" = $SETPROP';
# Output:  {"key":{"key-nested":"value"}}


# Ex 4 - jq set/replace
curl -sL -4 "https://ipinfo.io" 2>'/dev/null' | jq -cS --arg ts "$(date +'%Y-%m-%d @ %H:%M:%S';).$(date +'%N' | cut -c1-3;)" '{ip:.ip,org:.org} | ."_time" = $ts';
# Output:  {"_time":"[TIMESTAMP]","ip":"[WAN_IP]","org":"[ISP_NAME]"}


# Ex 5 - jq set/replace
cat "/etc/docker/daemon.json" | jq;
jq --arg SETPROP "local" '."log-driver" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "25m" '."log-opts"."max-size" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "1" '."log-opts"."max-file" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "false" '."log-opts"."compress" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
cat "/etc/docker/daemon.json" | jq;


# ------------------------------------------------------------
#
# jq - implode an array
#

# jq - implode (ex 1)
echo '[1,2,3,false,true,"a","b","c"]' | jq -r "join(\" \")";

# jq - implode (ex 2) - nested property
echo '{"key":[1,2,3,false,true,"a","b","c"]}' | jq -r ".key | join(\" \")";


# ------------------------------------------------------------
#
# jq - regex match/select
#

# jq  -  “test” (regex)  -  example: get array objects whose “name” property matches regex pattern (starts with at least 3 digits (0-9)))
JQ_QUERY='.[] | select(.name | test("^[0-9]{3,}")) | .name';
JSON='[{"name":"alpha"},{"name":"1-one"},{"name":"22-two"},{"name":"333-three"},{"name":"4444-four"}]';
echo "${JSON}" | jq -r "${JQ_QUERY}";


# ------------------------------------------------------------
#
# jq - select objects/array-items/properties based on their value(s)/nested-value(s)
#  |
#  |--> NOTE:  " | select(...)" is type-sensitive (ints require no quotes, strings require quotes around their compared value(s))
#

# jq - Select array item(s) based on their value(s)
JQ_QUERY='.[] | select(.id=="1") | .';
JSON='[{"id":"1","name":"obj1","value":"val1"},{"id":"2","name":"obj2","value":"val2"}]';
echo "${JSON}" | jq "${JQ_QUERY}";


# jq - Select object property's nested array item(s) based on its value(s)
JQ_QUERY='.value[] | select(.definition.id==1) | .';
JSON='{"count":3,"value":[{"definition":{"id":1}},{"definition":{"id":2}},{"definition":{"id":3}}]}';
echo "${JSON}" | jq "${JQ_QUERY}";


# ------------------------------------------------------------
#
# jq - count the number of items in an array (get the length of target object/array)
#

# jq 'length'
CIDR_ARR="$(curl -s "https://ip-ranges.atlassian.com" | jq -e '.items';)"; echo "${CIDR_ARR}" | jq -e 'length';


# ------------------------------------------------------------
#
# jq - Sorting
#

# jq - Sort by KEY using --sort-keys   (ex 1)
JSON='{"CCC":"CCC","BBB":"BBB","AAA":"AAA"}';
echo -e "Unsorted:\n$(echo "${JSON}" | jq;)";
echo -e "Sorted:\n$(echo "${JSON}" | jq --sort-keys;)";


# jq - Sort by PROPERTY using 'sort_by(...)'   (ex 1)
JSON='[{"name":"CCC","num":"333"},{"name":"BBB","num":"222"},{"name":"AAA","num":"111"}]';
echo -e "Unsorted:\n$(echo "${JSON}" | jq -r '.[].name';)";
echo -e "Sorted:\n$(echo "${JSON}" | jq -r 'sort_by(.name) | .[].name';)";


# jq - Sort by PROPERTY using 'sort_by(...)'   (ex 2)
#  |--> az cli - Get the list of preview features enabled for the user's default Microsoft Azure Cloud Subscription
az feature list | jq -r 'sort_by(.name) | .[] | select(.properties.state=="Registered") | .name';


# ------------------------------------------------------------
#
# jq - Verify that a key exists and is set
#
if [[ 1 -eq 1 ]]; then
JSON='{"key1":"val1","key2":"val2","key3":{"key31":"val31","key32":"val32"}}';
echo "------------------------------";
echo "JSON = ${JSON}";
echo "------------------------------";
KEY_TO_GET=".key3";
if [ "$(echo "${JSON}" | jq -r "${KEY_TO_GET}";)" != "null" ]; then
echo "Info - JSON key verified to exist: \"${KEY_TO_GET}\"";
else
echo "Error - JSON key not found: \"${KEY_TO_GET}\"";
fi;
echo "------------------------------";
KEY_TO_GET=".key4";
if [ "$(echo "${JSON}" | jq -r "${KEY_TO_GET}";)" != "null" ]; then
echo "Info - JSON key verified to exist: \"${KEY_TO_GET}\"";
else
echo "Error - JSON key not found: \"${KEY_TO_GET}\"";
fi;
echo "------------------------------";
fi;


# ------------------------------------------------------------
#
# jq - lowercase/uppercase a string
#

echo "${RBAC_JSON}" | jq -r ".[] | select((.principalId | ascii_downcase==\"IDENTITY_ID\") and (.roleDefinitionName | ascii_downcase==\"ROLE\") and (.scope | ascii_downcase==\"SCOPE\")).id";


# ------------------------------------------------------------
#
# jq - Modify the value held by a specific JSON key
#
if [[ 1 -eq 1 ]]; then
JSON='{"key1":"val1","key2":"val2","key3":{"key31":"val31","key32":"val32"}}';
MODIFIED_JSON=$(echo "${JSON}" | jq '.key3.key31 = "replaced-value"';);
MODIFIED_JSON_COMPRESSED=$(echo "${MODIFIED_JSON}" | jq -c .;);
echo "------------------------------";
echo "JSON = ${JSON}";
echo "------------------------------";
echo "MODIFIED_JSON = ${MODIFIED_JSON}";
echo "------------------------------";
echo "MODIFIED_JSON_COMPRESSED = ${MODIFIED_JSON_COMPRESSED}";
echo "------------------------------";
fi;


# ------------------------------------------------------------
#
# jq - Convert a bash associative array to a JSON object
#
unset DAT_ARRAY; declare -A DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=(["Key A"]="Val One");
DAT_ARRAY+=(["Key B"]="Val Two");
DAT_ARRAY+=(["Key 100"]="100");
DAT_ARRAY+=(["Key 200"]="200");
JSON_OUTPUT=$(for i in "${!DAT_ARRAY[@]}"; do echo "$i"; echo "${DAT_ARRAY[$i]}"; done | jq -n -R 'reduce inputs as $i ({}; . + { ($i): (input|(tonumber? // .)) })');
JSON_COMPRESSED=$(echo ${JSON_OUTPUT} | jq -c '.';);
echo "\${JSON_OUTPUT} = ${JSON_OUTPUT}"; echo "\${JSON_COMPRESSED} = ${JSON_COMPRESSED}";


# ------------------------------------------------------------
#
# jq - Convert a bash indexed array (non-associative) to a JSON object
#
unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Val-1");
DAT_ARRAY+=("Val-2");
DAT_ARRAY+=("Val-3");
DAT_ARRAY+=("Val-4");
JSON_OUTPUT=$(printf '%s\n' "${DAT_ARRAY[@]}" | jq -R '.' | jq -s '.';);
JSON_COMPRESSED=$(echo ${JSON_OUTPUT} | jq -c '.';);
echo "\${JSON_OUTPUT} = ${JSON_OUTPUT}"; echo "\${JSON_COMPRESSED} = ${JSON_COMPRESSED}";


# ------------------------------------------------------------
#
# jq - Get the first 2 items in the "items" key's array (which is within/just-under the main JSON object)
#
JSON_INPUT=$(curl "https://ip-ranges.atlassian.com";);
echo "${JSON_INPUT}" | jq '.items[0:2]';


# ------------------------------------------------------------
#
# jq - Grab JSON from the given URL
#   |--> Parse the "items" key from the top-level JSON object
#   |---> Parse all nested "cidr" keys within said "item" key
#
JSON_INPUT=$(curl "https://ip-ranges.atlassian.com";);
echo "${JSON_INPUT}" | jq '.items[] | .cidr';


# ------------------------------------------------------------
#
# jq - Grab JSON from the given URL
#   |--> Parse the "items" key from the top-level JSON object
#   |---> Parse all nested "cidr" keys within said "item" key
#   |----> Slice off all double-quotes (prepping for output)
#
JSON_INPUT=$(curl "https://ip-ranges.atlassian.com";);
echo "${JSON_INPUT}" | jq -re '.items[] | .cidr';


# ------------------------------------------------------------
#
# jq - Grab JSON from the given URL
#   |--> Parse the "items" key from the top-level JSON object
#   |---> Parse all nested "cidr" keys within said "item" key
#   |----> Slice off all double-quotes (prepping for output)
#   |-----> Wrap the jq call in a for-loop and add some string to the beginning/end of each line to prep it to-be-used-by as an NGINX IPv4 whitelist
#
CIDR_ARR="$(curl -s "https://ip-ranges.atlassian.com" | jq -e '.items';)"; for EACH_CIDR in $(echo "${CIDR_ARR}" | jq -re '.[].cidr' | sort;); do echo "allow ${EACH_CIDR};"; done;  echo "--- $(echo "${CIDR_ARR}" | jq -e 'length';) total entries ---";


# ------------------------------------------------------------
#
# jq - Combine/Consolidate multiple JSON files into a single JSON file
#

jq -n '[ inputs[] ]' *.json > combined.json;


# ------------------------------------------------------------
#
# jq - Collapse single elements to strings
#

JQ_QUERY='[.[] | .data = (.data | tostring)]'; cat data.json | jq "${JQ_QUERY}" > data-tostring.json;


# ------------------------------------------------------------
#
# jq - Search a JSON array for a specific value
#

if [[ 1 -eq 1 ]]; then
echo "------------------------------------------------------------";
CONTENTS_JSON="[\"refs/heads/dev\",\"refs/heads/main\",\"refs/heads/master\"]";
TEMP_JSON=$(mktemp;);
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
#
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
    # jq - replace/set/update key [ .applicationUrl ]
    #
    KEY_TO_GET=".applicationUrl";
    if [ "$(echo "${EACH_JSON_CONTENTS}" | jq -r "${KEY_TO_GET}";)" != "null" ]; then
      KEY_DESCRIPTION="Application URL/FQDN";
      KEY_TO_SET="${KEY_TO_GET}";
      KEY_VAL_TO_SET="\"${HOST_SCHEME_FQDN}\"";
      UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${KEY_TO_SET} |= ${KEY_VAL_TO_SET}";);
      echo -e " (Updated) $(printf '%-35s' "$KEY_DESCRIPTION";) ( ${KEY_TO_SET} )";
    fi;
    #
    # jq - check-for/get key [ .Bus ]
    #
    KEY_TO_GET=".Bus";
    if [ "$(echo "${EACH_JSON_CONTENTS}" | jq -r "${KEY_TO_GET}";)" != "null" ]; then
      # Service Bus Update
      if [ "${AQMP_SERVICE_NAME}" == "Azure Service Bus" ]; then
        #
        # jq - replace/set/update key [ .Bus.ServiceBus.ConnectionString ]
        #
        KEY_DESCRIPTION="Service Bus Connection String";
        KEY_TO_SET=".Bus.ServiceBus.ConnectionString";
        KEY_VAL_TO_SET="\"${SERVICE_BUS_CONNECTION_STRING}\"";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${KEY_TO_SET} |= ${KEY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$KEY_DESCRIPTION";) ( ${KEY_TO_SET} )";
        #
        # jq - replace/set/update key [ .Bus.ServiceBus.ServiceUri ]
        #
        KEY_DESCRIPTION="Service Bus Service URI";
        KEY_TO_SET=".Bus.ServiceBus.ServiceUri";
        KEY_VAL_TO_SET="\"${SERVICE_BUS_URI}\"";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${KEY_TO_SET} |= ${KEY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$KEY_DESCRIPTION";) ( ${KEY_TO_SET} )";
      fi;
      # RabbitMQ Update/Remove
      if [ "${AQMP_SERVICE_NAME}" == "RabbitMQ" ]; then
        #
        # jq - replace/set/update key [ .Bus.RabbitMq.Host ]
        #
        KEY_DESCRIPTION="RabbitMQ Hostname";
        KEY_TO_SET=".Bus.RabbitMq.Host";
        KEY_VAL_TO_SET="\"${RABBITMQ_HOSTNAME}\"";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${KEY_TO_SET} |= ${KEY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$KEY_DESCRIPTION";) ( ${KEY_TO_SET} )";
      else
        #
        # jq - delete key [ .Bus.RabbitMq ]
        #
        KEY_DESCRIPTION="Remove RabbitMQ from JSON";
        KEY_TO_SET=".Bus";
        KEY_VAL_TO_SET="del(.RabbitMq)";
        UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${KEY_TO_SET} |= ${KEY_VAL_TO_SET}";);
        echo -e " (Updated) $(printf '%-35s' "$KEY_DESCRIPTION";) ( ${KEY_TO_SET} )";
      fi;
    fi;
    #
    # jq - replace/set/update key [ .SqlServer.FilesDbConnection ]
    #
    KEY_TO_GET=".SqlServer.FilesDbConnection";
    if [ "$(echo "${EACH_JSON_CONTENTS}" | jq -r "${KEY_TO_GET}";)" != "null" ]; then
      KEY_DESCRIPTION="SQL Server Connection String";
      KEY_TO_SET="${KEY_TO_GET}";
      KEY_VAL_TO_SET="\"${SQL_CONNECTION_STRING}\"";
      UPDATED_JSON_CONTENTS=$(echo "${UPDATED_JSON_CONTENTS}" | jq "${KEY_TO_SET} |= ${KEY_VAL_TO_SET}";);
      echo -e " (Updated) $(printf '%-35s' "$KEY_DESCRIPTION";) ( ${KEY_TO_SET} )";
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
#
# Citation(s)
#
#   github.com  |  "Releases · stedolan/jq · GitHub"  |  https://github.com/stedolan/jq/releases
#
#   github.com  |  "GitHub - stedolan/jq: Command-line JSON processor"  |  https://github.com/stedolan/jq/
#
#   github.io  |  "[jq] Tutorial"  |  https://stedolan.github.io/jq/tutorial/
#
#   phpfog.com  |  "Sorting JSON by Value with JQ (Command Line JSON Processor) - PHPFog.com"  |  https://phpfog.com/sorting-json-by-value-with-jq
#
#   serverfault.com  |  "How to install jq on RHEL6.5 - Server Fault"  |  https://serverfault.com/a/768061
#
#   stackoverflow.com  |  "bash - Add new element to existing JSON array with jq - Stack Overflow"  |  https://stackoverflow.com/a/42248841
#
#   stackoverflow.com  |  "bash - jq returning null as string if the json is empty - Stack Overflow"  |  https://stackoverflow.com/a/53135202
#
#   stackoverflow.com  |  "bash - Modify a key-value in a json using jq - Stack Overflow"  |  https://stackoverflow.com/a/42717073
#
#   stackoverflow.com  |  "bash - Replace \n with space in jq query/command output without tr and sed commands - Stack Overflow"  |  https://stackoverflow.com/a/63239101
#
#   stackoverflow.com  |  "Constructing a json hash from a bash associative array - Stack Overflow"  |  https://stackoverflow.com/a/44792751
#
#   stackoverflow.com  |  "How to format a bash array as a JSON array"  |  https://stackoverflow.com/a/26809318
#
#   stackoverflow.com  |  "How do I select multiple fields in jq? - Stack Overflow"  |  https://stackoverflow.com/a/34835208
#
#   stackoverflow.com  |  "iteration - Output specific key value in object for each element in array with jq for JSON - Stack Overflow"  |  https://stackoverflow.com/a/35677443
#
#   stackoverflow.com  |  "json - Filter by Regex in JQ - Stack Overflow"  |  https://stackoverflow.com/a/50868294
#
#   stackoverflow.com  |  "json - How to check if element exists in array with jq - Stack Overflow"  |  https://stackoverflow.com/a/43269105
#
#   stackoverflow.com  |  "json - jq not working on tag name with dashes and numbers - Stack Overflow"  |  https://stackoverflow.com/a/37344498
#
#   stackoverflow.com  |  "json - Select objects based on value of variable in object using jq - Stack Overflow"  |  https://stackoverflow.com/a/18608100
#
#   unix.stackexchange.com  |  "Merging multiple json file into one object using JQ with argument - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/questions/588063
#
# ------------------------------------------------------------