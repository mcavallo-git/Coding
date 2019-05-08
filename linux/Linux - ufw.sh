# --------------------------------------------------------------------------------------------------------------------------------------- #

ufw allow 22/tcp;  # allow ssh-requests (22)

ufw allow 80/tcp;  # allow web-requests (80)

ufw allow 443/tcp; # allow web-requests (443)

ufw default deny incoming;  # deny other incoming requests, by default

ufw default allow outgoing; # allow all outgoing requests, by default

ufw logging on; ufw enable; # enable logging and enable ufw itself















#
# Citation(s)
#
#		Documentation
#			--> ?
#
#		Forum
#			--> https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
#			--> https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
#