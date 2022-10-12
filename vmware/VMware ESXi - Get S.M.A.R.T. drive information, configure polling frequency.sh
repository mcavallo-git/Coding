#!/bin/sh

/sbin/smartd;
cat /var/log/syslog.log | tail -n 20;
# smartd: [error] Unable to lock PID file: smartd is already running

/etc/init.d/smartd stop;

/etc/init.d/smartd status;

/sbin/smartd --help;
# smartd <options>
#    -i   Polling interval (in minutes) for smartd
#         (default Polling interval is 30 minutes)


/sbin/smartd -i 1;


cat /etc/init.d/smartd;

cat /etc/vmware/smart_plugin.conf;

find / -iname *smart*;

cat /var/run/vmware/smartd.PID
# /etc/init.d/smartd
# /etc/vmware/smart_plugin.conf
# /etc/vmware/default.map.d/smartpqi.map
# /var/run/vmware/smartd.PID
# /var/lib/initenvs/installer/chkconfig/disabled/smartd
# /tardisks/smartpqi.v00
# /bin/smartd
# /lib64/libsmartmgt.so
# /lib/libsmartmgt.so
# /usr/share/hwdata/default.pciids.d/smartpqi.ids
# /usr/lib/vmware/smart_plugins
# /usr/lib/vmware/smart_plugins/libsmartnvme.so
# /usr/lib/vmware/smart_plugins/libsmartmicron.so
# /usr/lib/vmware/smart_plugins/libsmartscsi.so
# /usr/lib/vmware/smart_plugins/libsmartsata.so
# /usr/lib/vmware/vm-support/bin/smartinfo
# /usr/lib/vmware/vmkmod/smartpqi


# Find the process which is holding up smartd from working as intended
cat /var/run/vmware/smartd.PID


ps | grep $(cat /var/run/vmware/smartd.PID;);
# No processes found --> PID file is a dangling pointer --> remove it

rm -fv /var/run/vmware/smartd.PID;

/etc/init.d/smartd start;

# ------------------------------

vi "/etc/rc.local.d/local.sh";

# Add the following into "local.sh":

# Poll the SMART daemon every 5 minutes (instead of the default of every 30)
SMARTD_POLL_INTERVAL=5
/etc/init.d/smartd stop;
sed -r "s/^(.+ -t \"\\\$\{MAX_RETRIES\}\" )(.+$)/\1-i ${SMARTD_POLL_INTERVAL:-5} \2/g" -i "/etc/init.d/smartd";
/etc/init.d/smartd start;



# ------------------------------

# Pre-Check - Get the config & service status before running the update
cat /etc/init.d/smartd;  ps -c | grep smartd | grep -v grep; 

# Run the update
/etc/rc.local.d/local.sh

# Post-Check - Verify the configuration was applied as-intended
cat /etc/init.d/smartd;  ps -c | grep smartd | grep -v grep; 


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "ESXi S.M.A.R.T. health monitoring for hard drives (2040405)"  |  https://kb.vmware.com/s/article/2040405
#
#   williamlam.com  |  "Quick Tip - smartd configurable polling interval in vSphere 6.0"  |  https://williamlam.com/2015/02/quick-tip-smartd-configurable-polling-interval-in-vsphere-6-0.html
#
# ------------------------------------------------------------