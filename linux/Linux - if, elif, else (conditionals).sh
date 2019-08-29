# ------------------------------------------------------------
#
#	If [ Not Null/Unset ]
#
#	Example
#		Determine if [string] variable has a value using [ -n ] comparator

VAR="hello"
if [ -n "${VAR}" ]; then
	echo "VAR has a value of \"${VAR}\"";
else
	echo "VAR is Null/Unset";
fi;



# ------------------------------------------------------------
#
#	If [ Null/Unset ]
#
#	Example
#		Use parameter expansion to determine if a given VAR has been instantiated:  ${<VAR>+x}
#		( Citation: Thanks to user 'Cheeso' on stackoverflow - https://stackoverflow.com/questions/3601515 )
#

if [ -z ${VAR+x} ]; then
	echo "VAR is Null/Unset";
else
	echo "VAR is set to '${VAR}'";
fi;



# ------------------------------------------------------------
#
#		If [ Not-Null ]
#

if [ -n "${SUBDOMAIN}" ] && [ -n "${DOMAIN}" ]; then # vars are both set & not empty
	FQDN="${SUBDOMAIN}.${DOMAIN}";
	echo "${FQDN}";
else
	echo "VAR(S) NOT SET";
fi;



# ------------------------------------------------------------
#
#		If [ String == String ]
#
if [ "${s1}" == "${s2}" ]; then
	echo "Strings ARE equal ";
else
	echo "Strings are NOT equal";
fi;



# ------------------------------------------------------------
#
#	If [ Needle-in-Haystack ]
#
#	Example
#		Perform a case-insensitive substring comparison
#		( Citation: Thanks to user 'marcog' on stackoverflow - https://stackoverflow.com/questions/4277665 )
#

if [[ "${HAYSTACK}" == *"${NEEDLE}"* ]]; then # Needle found in haystack
	echo "Haystack \"${HAYSTACK}\" contains Needle \"${NEEDLE}\"";
else
	echo "Needle \"${NEEDLE}\" not found in Haystack \"${HAYSTACK}\"";
fi;



# ------------------------------------------------------------
#
#	If [ String passes regex test ]
#
#
#	Example
#		Check to see if string is a date in 'yyyymmdd' format
#		( Citation: Thanks to user 'fedorqui' on stackoverflow - https://stackoverflow.com/questions/21112707 )
#

StringToTest="20190331";
if [[ ${StringToTest} =~ ^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$ ]]; then
	echo "Valid Date: \"${StringToTest}\"";
else
	echo "Invalid Date: \"${StringToTest}\"";
fi;



# ------------------------------------------------------------
#
#	If [...] Then {...}
#	Else-If [...] Then {...}
#	Else-If [...] Then {...}
#	Else {...}
#
#		Example File: /bash_x
#		Example Desc:  Check if a valid-first-argument was passed to current script, fail-out otherwise
#
if [ -n "$0" ]; then
	DK_CMD="${0}";
	if [[ "${DK_CMD}" == "/bash_production" ]] || [[ "${DK_CMD}" == "/bashprod" ]]; then
		echo "Production";
	elif [[ "${DK_CMD}" == "/bash_development" ]] || [[ "${DK_CMD}" == "/bashdev" ]]; then
		echo "Development";
	elif [[ "${DK_CMD}" == "/bash_quality_assurance" ]] || [[ "${DK_CMD}" == "/bashqa" ]]; then
		echo "Quality Assurance";
	else
		echo "\n\n$ 0: Un-handled Bash Command: \"${0}\"\n\n";
		exit 1;
	fi;
else 
	echo "\n\n$ 0: Variable is either unset or contains a null value\n\n";
	exit 1;
fi;
exit 0;



# ------------------------------------------------------------
#
# Determine if a given Linux-Command exists
#
COMMAND_LOOKUP="docker";
COMMAND_FOUND=0;
echo ""
echo "Checking for Linux Command \"${COMMAND_LOOKUP}\" on \"$(hostname)\"...";
if ! COMMAND_RESOLVED_PATH="$(type -p "$COMMAND_LOOKUP")" || [ -z "$COMMAND_RESOLVED_PATH" ]; then
	echo "  Command NOT found: \"${COMMAND_LOOKUP}\"";
	COMMAND_FOUND=0;
else
	echo "  Command FOUND: \"${COMMAND_LOOKUP}\" -> \"${COMMAND_RESOLVED_PATH}\"";
	COMMAND_FOUND=1;
fi;
IS_DOCKER_INSTALLED=${COMMAND_FOUND};



# ------------------------------------------------------------
#
# Determine if a given Linux-User exists
#
DOES_USER_EXIST="ubuntu";
if [ -n "$(id -u ${DOES_USER_EXIST})" ]; then # user-id exists in this environment
# if [[ $(id -u ${DOES_USER_EXIST}) =~ ^-?[0-9]+$ ]]; then
echo "USER \"${DOES_USER_EXIST}\" EXISTS!";
else # no user-id tied to given username in this environment
echo "USER \"${DOES_USER_EXIST}\" does NOT exist";
fi;



# ------------------------------------------------------------
#
# Get a NON-EMPTY response string from the user running a given script
#   NOTE: allows spaces and zero
#
echo "";
echo "Did you enter a non-empty string?";
read -p "Your response:  " -t 20 -r;
# Check for valid data-entry
if [ ! -n "${REPLY}" ]; then
	echo "";
	echo "Empty or Null response detected - exiting...";
	exit 1;
else
	echo "";
	echo "Great! You entered a non-empty string!";
fi;



# ------------------------------------------------------------
#
# Single-Line Conditionals
#

# (single-line example) Check for error & exit
ERROR_CODE=$?; if [ ${ERROR_CODE} -ne 0 ]; then echo "$(date +'%D  %r') EXITING WITH ERROR_CODE=${ERROR_CODE}"; exit 1; else echo "$(date +'%D  %r') EXITING WITH ERROR_CODE=${ERROR_CODE}"; exit 0; fi;

# (single-line example) Is this Linux Distribution "CentOS"? (return 1 if true, 0 if false)
OS_IS_CENTOS=$(if [[ $(cat /etc/*release | grep -i centos | wc -l) -gt 0 ]]; then echo "1"; else echo "0"; fi; );

# (single-line example) Is this Linux Distribution "Ubuntu"? (return 1 if true, 0 if false)
OS_IS_UBUNTU=$(if [[ $(cat /etc/*release | grep -i ubuntu | wc -l) -gt 0 ]]; then echo "1"; else echo "0"; fi; );



# ------------------------------------------------------------
#
# Get all SSH-Enabled users on the server
#
ALL_LINUX_USERS=$(cut -d: -f1 /etc/passwd);
for EACH_SSH_USER in ${ALL_LINUX_USERS}; do
	DIR_USER_HOME=$(eval echo ~${EACH_SSH_USER});
	DIR_SSH_HOME="${DIR_USER_HOME}/.ssh";
	DIR_ETC_KEYS="/etc/ssh/authorized_keys";
	FILE_SSH_ETC="${DIR_ETC_KEYS}/${EACH_SSH_USER}";
	if [ -d "${DIR_SSH_HOME}" ] || [ -f "${FILE_SSH_ETC}" ]; then
		echo "User [${EACH_SSH_USER}] IS an SSH-User";
	else
		echo "User [${EACH_SSH_USER}] ISNT an SSH-User";
	fi;
done;



# ------------------------------------------------------------
#
#	Variable Comparisons
#		|--> Includes logic for Integers, Floats/Doubles, and Strings (ASCII)
#
# ------------------------------------------------------------
#
#
#  ==		String (IS_INTEGER TEST):
#					if [[ $A =~ ^-?[0-9]+$ ]]   :::   True if $A is an integer (string input, only)
#					if [[ "$A" =~ ^-?[0-9]+$ ]]   :::   True if $A is an integer (strings, integer, or float input)
#
#
#
#  ==		Strings:
#					if [ "$A" == "$B" ]  :::  True if $A is equal to $B
#  ==		Integers:
#					if [ $A -eq $B ]     :::  True if $A is equal to $B
#					if [ "$a" == "z*" ]  :::  True if $A is equal to z* (literal matching).
#					if [ $a == z* ]      :::  File globbing and word splitting take place.
#					if [[ $A == z* ]]    :::  True if $A starts with an "z" (string pattern matching).
#					if [ "$a" == "z*" ]  :::  True if $A is equal to z* (literal matching).
#					if [[ $a == "z*" ]]  :::  True if $a is equal to z* (literal matching).
#  ==		Floats/Doubles:
#					if [ $(echo "$A == $B" | bc) -eq 1 ]; then echo "$A IS equal to $B"; else echo "$A ISNT equal to $B"; fi;
#
#
#
#  !=		Strings:
#					if [ "$A" != "$B" ] :::  True if $A not equal to $B
#  !=		Integers:
#					if [ $A -ne $B ]    :::  True if $A not equal to $B
#					if [ "$A" != "$B" ] :::  True if $A not equal to $B (can also pattern match, see '==' section, above)
#  !=		Floats/Doubles:
#					if [ $(echo "$A != $B" | bc) -eq 1 ]; then echo "$A IS a different value than $B"; else echo "$A ISNT a different value than $B"; fi;
#
#
#
#  <		Integers:
#					if [ $A -lt $B ]     :::  True if $A is less than $B
#					if (("$A" < "$B"))   :::  True if $A is less than $B
#					if [[ "$A" < "$B" ]] :::  True if $A, as a string, has a lesser ASCII value than $B does, also as a string
#					if [ "$A" \< "$B" ]  :::  Same as previous? --> Note that the "<" needs to be escaped within a [ ] construct
#  <		Floats/Doubles:
#					if [ $(echo "$A < $B" | bc) -eq 1 ]; then echo "$A IS less than $B"; else echo "$A ISNT less than $B"; fi;
#
#
#
#  <=		Integers:
#					if [ $A -le $B ]     :::  True if $A is less than or equal to $B
#					if (("$A" <= "$B"))  :::  True if $A is less than or equal to $B
#  <=		Floats/Doubles:
#					if [ $(echo "$A <= $B" | bc) -eq 1 ]; then echo "$A IS less than or equal to $B"; else echo "$A ISNT less than or equal to $B"; fi;
#
#
#
#  >		Integers:
#					if [ $A -gt $B ]     :::  True if $A (as an int) is greater than $B (as an int)
#					if [ "$A" -gt "$B" ] :::  True if $A (as an int) is greater than $B (as an int)
#					if (("$A" > "$B"))   :::  True if $A is greater than $B
#					if [[ "$A" > "$B" ]] :::  True if $A (as a string) is greater than $B (as a string) - the greater ASCII value trumps
#					if [ "$A" \> "$B" ]  :::  Same as previous? --> Note that the ">" needs to be escaped within a [ ] construct
#  >		Floats/Doubles:
#					if [ $(echo "$A > $B" | bc) -eq 1 ]; then echo "$A IS greater than $B"; else echo "$A ISNT greater than $B"; fi;
#	
#
#
#  >=		Integers:
#					if [ $A -ge $B ]    :::  True if $A is greater than or equal to $B
#					if (("$A" >= "$B")) :::  True if $A is greater than or equal to $B
#  >=		Floats/Doubles:
#					if [ $(echo "$A >= $B" | bc) -eq 1 ]; then echo "$A IS greater than or equal to $B"; else echo "$A ISNT greater than or equal to $B"; fi;
#
#
#
# ------------------------------------------------------------
#
#  Check whether a string contains non-numeric characters.
#    |--> Replace all digit characters with blanks (remove them) then get the final length of the string
#    |--> Any value greater than 0 for the length of the string means non-integer character(s) were found
#
#  if [[ -z ${foo//[0-9]/} ]]; then
#    echo "foo is an integer!";
#  fi;

# ------------------------------------------------------------
#  
#  Compare [ the value of a variable evaluated in arithmetic context ] to [ the value of the same variable in non-arithmetic (e.g. string) context ]
#  If the value of the two contexts are equal to each other, the string is an integer
#  THIS IS BASH-SPECIFIC
#
#  if [[ $((foo)) == $foo ]]; then
#    echo "foo is an integer!";
#  fi;
#
# ------------------------------------------------------------
#
#
#  null
#					if [ -z $A ]      :::  True if A is a string and is null (has zero length)
#
#
#  not-null
#					if [ -n $A ]      :::  True if A is a string and ISNT null (non-zero string-length)
#
#
#
# ------------------------------------------------------------
#
# Filepath Conditionals   (whether path exists or not, is readable, is writeable, etc.)
#
#
#			-a FILE  :::  True if file exists.
#			-b FILE  :::  True if file exists and is a block special file.
#			-c FILE  :::  True if file exists and is a character special file.
#			-d FILE  :::  True if file exists and is a directory.
#			-e FILE  :::  True if file exists.
#			-f FILE  :::  True if file exists and is a regular file.
#			-g FILE  :::  True if file exists and its set-group-id bit is set.
#			-h FILE  :::  True if file exists and is a symbolic link.
#			-k FILE  :::  True if file exists and its "sticky" bit is set.
#			-p FILE  :::  True if file exists and is a named pipe (FIFO).
#			-r FILE  :::  True if file exists and is readable.
#			-s FILE  :::  True if file exists and has a non-zero filesize.
#			-t FD    :::  True if file descriptor fd is open and refers to a terminal.
#			-u FILE  :::  True if file exists and its set-user-id bit is set.
#			-w FILE  :::  True if file exists and is writable.
#			-x FILE  :::  True if file exists and is executable.
#			-G FILE  :::  True if file exists and is owned by the effective group id.
#			-L FILE  :::  True if file exists and is a symbolic link.
#			-N FILE  :::  True if file exists and has been modified since it was last read.
#			-O FILE  :::  True if file exists and is owned by the effective user id.
#			-S FILE  :::  True if file exists and is a socket.
#
#
#
# ------------------------------------------------------------
#
# Citation(s)
#		
#		www.tldp.org
#		"7.3. Other Comparison Operators" (Integer/String Conditionals)
#		 https://www.tldp.org/LDP/abs/html/comparison-ops.html
#
#		
#		www.gnu.org
#		"6.4 Bash Conditional Expressions"
#		 https://www.gnu.org/software/bash/manual/bashref.html#Bash-Conditional-Expressions
#
#		
#		stackoverflow.com
#		"Is there an easy way to determine if user input is an integer in bash?"
#		 https://stackoverflow.com/questions/4137262
#
#
#
# ------------------------------------------------------------