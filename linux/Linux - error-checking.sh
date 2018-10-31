
# Perform a silent check for error(s) in a given command, and exit if errors were output by method
which git > /dev/null 2>&1;
ERROR_CODE=$?;
if [ ${ERROR_CODE} -ne 0 ]; then
	echo "$(date +'%D  %r') EXITING WITH ERROR_CODE=${ERROR_CODE}";
	exit 1;
else
	echo "$(date +'%D  %r') EXITING WITH ERROR_CODE=${ERROR_CODE}";
	exit 0;
fi;


# Thanks to user "haxxor" on the StackExchange forums
#  --> https://unix.stackexchange.com/questions/163352/what-does-dev-null-21-mean-in-this-article-of-crontab-basics
# "
#		/dev/null is a device file that acts like a blackhole. Whatever that is written to it, get discarded or disappears. When you run a script that gives you an output and if we add a > /dev/null 2>&1 at the end of the script, we are asking the script to write whatever that is generated from the script (both the output and error messages) to /dev/null.
#		To break it up:
#		2 is the handle for standard error or STDERR
#		1 is the handle for standard output or STDOUT
#		2>&1 is asking to direct all the STDERR as STDOUT, (ie. to treat all the error messages generated from the script as its standard output). Now we already have > /dev/null at the end of the script which means all the standard output (STDOUT) will be written to /dev/null. Since STDERR is now going to STDOUT (because of 2>&1) both STDERR and STDOUT ends up in the blackhole /dev/null. In other words, the script is silenced.
# ""
