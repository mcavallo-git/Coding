#!/bin/sh

if [ "$(id -un)" != "root" ]; then

echo "Error:  Must run ${0} as user 'root'";
exit 1;

else

SEPARATOR="------------------------------------------------------------";
for EachUser in $(cut -f1 -d: /etc/passwd); do 
EachCrontab=$(crontab -u "$EachUser" -l) > /dev/null 2>&1;
if [ -n "${EachCrontab}" ]; then
echo -e "|${SEPARATOR}\n|\n|   crontab -u \"${EachUser}\" -l\n|\n${EachCrontab}\n${SEPARATOR}\n";
fi;
done;

fi;


#
#	Citation(s)
#
#	Thanks to cyberciti user [ Dovryak ] on forum [ https://www.cyberciti.biz/faq/linux-show-what-cron-jobs-are-setup/ ]
#