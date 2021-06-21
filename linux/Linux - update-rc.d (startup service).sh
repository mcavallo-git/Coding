# ------------------------------------------------------------
# Add a startup service (debian distros):
SVC="nginx";
systemctl enable "${SVC}.service" --now; # "enable --now" autostarts service at bootup && starts service immediately
update-rc.d ${SVC} defaults;


# ------------------------------------------------------------

# Remove a startup service (debian distros):
SVC="nginx";
systemctl disable "${SVC}.service" --now; # "disable --now" removes service from startup services & stops service immediately
update-rc.d ${SVC} remove -f;


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "autostart - How can I configure a service to run at startup - Ask Ubuntu"  |  https://askubuntu.com/a/574054
#
# ------------------------------------------------------------