# ------------------------------------------------------------
# Linux - smartctl (get disk S.M.A.R.T. values, remaining disk life, wear leveling count)
# ------------------------------------------------------------


# Install smartctl
sudo apt-get -y update;
sudo apt-get -y install smartmontools;


# Enable S.M.A.R.T. on target disk
smartctl --smart=on /dev/sda


# Get target disk's S.M.A.R.T. information (-i) and data (-A)
smartctl -A -i /dev/sda;


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "smart - Samsung SSD "Wear_Leveling_Count" meaning - Super User"  |  https://superuser.com/a/1615974
#
# ------------------------------------------------------------