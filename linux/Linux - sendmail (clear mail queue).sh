
# Linux - Sendmail (clear outgoing mail, which is waiting to be sent as a group of files in "/var/spool/mqueue/*")

for file in $(grep -l email@domain.com /var/spool/mqueue/*); do
	rm $file;
done;

for file in $(grep -l SQL/DB /var/spool/mqueue/*); do
	rm $file;
done;
