@echo OFF
REM
REM
REM    w32tm  :::  WINDOWS TIME SERVICE
REM      |
REM      |-->  USE THIS SERVICE TO QUERY AN NTP SERVER FOR CURRENT-TIME
REM


REM --> set target ntp server (hostname or IP)
REM set NTP_HOST=time.google.com
set NTP_HOST=time.nist.gov


REM --> grab the [ response delay ] from the NTP server
ping %NTP_HOST% -n 1


REM --> grab the [ current time ] from the NTP server
w32tm /stripchart /computer:%NTP_HOST% /dataonly /samples:5

timeout -t 30

exit

REM 
REM   NTP-SERVER RESPONSE-TIMES    ==>    FASTEST:   time1.google.com
REM    |
REM    |
REM    |
REM    |-->  NIST  ==> https://tf.nist.gov/tf-cgi/servers.cgi
REM    |      |
REM    |      |-->   PROXY  :::   time.google.com    :::   [VARIES]
REM  ! |      |-->   58ms   :::   time1.google.com   :::   216.239.35.0
REM    |      |-->   66ms   :::   time2.google.com   :::   216.239.35.4
REM    |      |-->   124ms  :::   time3.google.com   :::   216.239.35.8
REM    |      |-->   216ms  :::   time4.google.com   :::   216.239.35.12
REM    |      |
REM    |      X
REM    |
REM    |-->  Google   ==>   ping time1.google.com && ping time2.google.com && ping time3.google.com && ping time4.google.com
REM    |      |
REM    |      |-->   PROXY  :::   time.google.com    :::   [VARIES]
REM  ! |      |-->   58ms   :::   time1.google.com   :::   216.239.35.0
REM    |      |-->   66ms   :::   time2.google.com   :::   216.239.35.4
REM    |      |-->   124ms  :::   time3.google.com   :::   216.239.35.8
REM    |      |-->   216ms  :::   time4.google.com   :::   216.239.35.12
REM    |      |
REM    |      X
REM    |
REM    |
REM    |-->  NTP-Pool-Project
REM    |      |
REM    |      |--> USA   ==>   ping 0.us.pool.ntp.org && ping 1.us.pool.ntp.org && ping 2.us.pool.ntp.org && ping 3.us.pool.ntp.org
REM    |      |     |
REM    |      |     |-->   PROXY  :::   us.pool.ntp.org     :::   [PROXY]
REM    |      |     |-->   69ms   :::   0.us.pool.ntp.org   :::   154.16.245.246
REM    |      |     |-->   64ms   :::   1.us.pool.ntp.org   :::   162.248.241.94
REM    |      |     |-->   63ms   :::   2.us.pool.ntp.org   :::   129.250.35.250
REM    |      |     |-->   52ms   :::   3.us.pool.ntp.org   :::   4.53.160.75,  173.255.215.209
REM    |      |     X
REM    |      |
REM    |      |--> Ubiquiti   ==>   ping 0.ubnt.pool.ntp.org && ping 1.ubnt.pool.ntp.org && ping 2.ubnt.pool.ntp.org && ping 3.ubnt.pool.ntp.org
REM    |      |     |
REM    |      |     |-->   74ms   :::   0.ubnt.pool.ntp.org   :::   209.133.217.165,  ...?
REM    |      |     |-->   55ms   :::   1.ubnt.pool.ntp.org   :::   96.245.170.99,  162.210.110.4,  69.195.159.158
REM    |      |     |-->   128ms  :::   2.ubnt.pool.ntp.org   :::   216.218.254.202,  ...?
REM    |      |     |-->   83ms   :::   3.ubnt.pool.ntp.org   :::   23.239.26.89,  ...?
REM    |      |     X
REM    |      X
REM    |       
REM    V

REM   REFERENCE(S):
REM     https://support.4it.com.au/article/check-a-ntp-server-date-and-time-using-the-windows-command-prompt/
REM     https://docs.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings
