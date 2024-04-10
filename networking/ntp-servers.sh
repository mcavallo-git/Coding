# ------------------------------------------------------------
#
# Hostname NTP (Network Time Protocol) Servers
#

### If using 4 NTP Hostnames (Best-Practice)
1.us.pool.ntp.org, pool.ntp.org, time-a-g.nist.gov, time.google.com

### If using 3 NTP Hostnames
pool.ntp.org, time.nist.gov, time.google.com

### If using 2 NTP Hostnames
pool.ntp.org, time.nist.gov

### If using 1 NTP Hostname
pool.ntp.org


# ------------------------------------------------------------
#
# Static IPv4 NTP (Network Time Protocol) Servers
#

129.6.15.28      time-a-g.nist.gov       #  NIST, Gaithersburg, Maryland
132.163.96.1     time-a-b.nist.gov       #  NIST, Boulder, Colorado
132.163.97.1     time-a-wwv.nist.gov	   #  WWV, Fort Collins, Colorado
128.138.140.44   utcnist.colorado.edu    #  University of Colorado, Boulder


# ------------------------------------------------------------
#
# Test an NTP server using "ntpdate" (gets time offset between local and server clocks)
#

ntpdate -q 1.us.pool.ntp.org
ntpdate -q pool.ntp.org
ntpdate -q time-a-g.nist.gov
ntpdate -q time.google.com


# ------------------------------------------------------------
#
# Citation(s)
#
#   gist.github.com  |  "List of Top Public Time Servers · GitHub"  |  https://gist.github.com/mutin-sa/eea1c396b1e610a2da1e5550d94b0453
#
#   superuser.com  |  "redhat enterprise linux - how to test ntp servers as real servers - Super User"  |  https://superuser.com/a/1722743
#
#   tf.nist.gov  |  "NIST Internet Time Service"  |  https://tf.nist.gov/tf-cgi/servers.cgi
#
# ------------------------------------------------------------