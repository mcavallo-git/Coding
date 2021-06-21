
# Add a startup service:
SERVICE_NAME="unifi"; update-rc.d ${SERVICE_NAME} defaults;

# Remove a startup service:
SERVICE_NAME="unifi"; update-rc.d ${SERVICE_NAME} remove -f;


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "autostart - How can I configure a service to run at startup - Ask Ubuntu"  |  https://askubuntu.com/a/574054
#
# ------------------------------------------------------------