#!/bin/bash
# ------------------------------------------------------------
# Linux - rsyslog, rsyslog.d (redirecting logs away from syslog to specific logfiles, cron logs)
# ------------------------------------------------------------
#
# rsyslog - Base config file location
#
cat "/etc/rsyslog.conf";


#
# rsyslog - Additional config files location
#
ls -al "/etc/rsyslog.d";


# ------------------------------------------------------------
#
# rsyslog - Get recent cronjob runs from syslog
#
grep CRON "/var/log/syslog" | tail -n 50 | grep CRON;


# ------------------------------------------------------------
#
# Use sed to parse-out and remove the comment block in-front of the cron logger
#
RSYSLOG_DEFAULTS_CONF="/etc/rsyslog.d/50-default.conf";
SED_ENABLE_CRON_LOGS='s|^#cron|cron|g';
sed -i -e "${SED_ENABLE_CRON_LOGS}" "${RSYSLOG_DEFAULTS_CONF}";
# "#cron.*                         /var/log/cron.log"


# ------------------------------------------------------------
#
# Example) Redirect service-specific syslogs to their own logfile at /var/log/
#

if [[ 1 -eq 1 ]]; then
  # ------------------------------------------------------------
  #
  SERVICE="iptables";
  FILTER_SYSLOGS_CONTAINING="netfilter";
  #
  # ------------------------------------------------------------
  #
  # Reconfigure rsyslogd to send syslog messages containing the string "netfilter" to logfile "/var/log/iptables.log" and then stop processing rules (don't also log them to "/var/log/syslog")
  #
  RSYSLOG_CONF="/etc/rsyslog.d/01-${SERVICE}.conf";
  LOGFILE_SERVICE="/var/log/${SERVICE}.log";
  echo -n -e ":msg,contains,\"${FILTER_SYSLOGS_CONTAINING}:\" ${LOGFILE_SERVICE}""\n""&stop" > "${RSYSLOG_CONF}";
  # [line 1]   :msg,contains,"netfilter:" /var/log/iptables.log
  # [line 2]   &stop
  #  ^ The first line directs messages containing the string “netfilter:” into the given file, /var/log/iptables.log.
  #  ^ The “&stop” line stops processing at that point, so that the messages are not duplicated to the above files (where rsyslog sends them due to its main config file).
  #
  # ------------------------------------------------------------
  #
  # logrotate - ⚠️ Update logrotate's rsyslog configuration to include the new logfile when rotating logs ⚠️
  #
  LOGROTATE_CONF="/etc/logrotate.d/rsyslog";
  if [ -n "$(cat "${LOGROTATE_CONF}" | grep -n "${LOGFILE_SERVICE}" | wc -l;)" -eq 0 ]; then
    PATTERN_FILE_LINE="^/var/log/debug\s*$";
    sed -i -r -e "/${PATTERN_FILE_LINE//\//\\\/}/{" -e "i\\${LOGFILE_SERVICE//\//\\\/}" -e "}" "${LOGROTATE_CONF}";
    #  ^ Prepends the line "/var/log/${SERVICE}.log" before the line "/var/log/debug" in the logrotate rsyslog configuration file
  fi;
  #
  # logrotate - Verify Log File Rotation
  #   In order to verify rotation of the new file, check back after a few days.
  #   As well as the ${SERVICE}.log file, you should see the preserved file ${SERVICE}.log.1“.
  #   If not, force a rotation by typing:
  #     logrotate --force /etc/logrotate.d/rsyslog;
  #
  # ------------------------------------------------------------
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   serverfault.com  |  "Configuring Rsyslog To Stop The Logging Of Certain Messages - Server Fault"  |  https://serverfault.com/a/662608
#
#   stackoverflow.com  |  "linux - Details of last ran cron job in Unix-like systems? - Stack Overflow"  |  https://stackoverflow.com/a/11131533
#
#   unix.stackexchange.com  |  "docker - How to prevent rsyslog from logging cron tasks to /var/log/syslog using additional config - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/663694
#
#   unixetc.co.uk  |  "Redirecting Firewall Messages in Linux | Unix etc"  |  http://unixetc.co.uk/2019/04/26/redirecting-firewall-messages-in-linux
#
#   www.rsyslog.com  |  "RSyslog Documentation - rsyslog"  |  https://www.rsyslog.com/doc/v8-stable/configuration/index.html
#
#   www.tenable.com  |  "4.3 Ensure logrotate is configured | Tenable®"  |  https://www.tenable.com/audits/items/CIS_Ubuntu_18.04_LXD_Host_v1.0.0_L1_Workstation.audit:d69cc853f4894c260643f06b2c48bd7e
#
#   www.thegeekdiary.com  |  "Understanding the /etc/rsyslog.conf file for configuring System Logging – The Geek Diary"  |  https://www.thegeekdiary.com/understanding-the-etc-rsyslog-conf-file-for-configuring-system-logging/
#
# ------------------------------------------------------------