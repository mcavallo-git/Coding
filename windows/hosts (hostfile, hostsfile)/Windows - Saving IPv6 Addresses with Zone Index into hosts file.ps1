
<# ------------------------------------------------------------ #>

<#
From Citation(s) (Below):
"
Finally, I've found the way. I speicied zone ID (11 in my case) in hosts:

fe80::215:afff:fec6:ea64%11 realhost
Which I've got using

netsh interface ipv6 show addresses
With help of http://technet.microsoft.com/en-us/library/bb726995.aspx
"
#>

<# ------------------------------------------------------------ #>
<#
REFER TO:

"%USERPROFILE%\Documents\GitHub\Coding\cmd\cmd - ping ipv6 localhost (zone index test).bat"

#>

<# Test by replacing "::1" in the below ping calls with your target IPv6 Address... #>
ping -n 1 -w 1 ::1%1
ping -n 1 -w 1 ::1%2
ping -n 1 -w 1 ::1%3
ping -n 1 -w 1 ::1%4
ping -n 1 -w 1 ::1%5
ping -n 1 -w 1 ::1%6
ping -n 1 -w 1 ::1%7
ping -n 1 -w 1 ::1%8
ping -n 1 -w 1 ::1%9
ping -n 1 -w 1 ::1%10
ping -n 1 -w 1 ::1%11
ping -n 1 -w 1 ::1%12
ping -n 1 -w 1 ::1%13
ping -n 1 -w 1 ::1%14
ping -n 1 -w 1 ::1%15
ping -n 1 -w 1 ::1%16
ping -n 1 -w 1 ::1%17
ping -n 1 -w 1 ::1%18
ping -n 1 -w 1 ::1%19
ping -n 1 -w 1 ::1%20
ping -n 1 -w 1 ::1%21
ping -n 1 -w 1 ::1%22
ping -n 1 -w 1 ::1%23
ping -n 1 -w 1 ::1%24
ping -n 1 -w 1 ::1%25
ping -n 1 -w 1 ::1%26
ping -n 1 -w 1 ::1%27
ping -n 1 -w 1 ::1%28
ping -n 1 -w 1 ::1%29
ping -n 1 -w 1 ::1%30
ping -n 1 -w 1 ::1%31
ping -n 1 -w 1 ::1%32
ping -n 1 -w 1 ::1%33
ping -n 1 -w 1 ::1%34
ping -n 1 -w 1 ::1%35
ping -n 1 -w 1 ::1%36
ping -n 1 -w 1 ::1%37
ping -n 1 -w 1 ::1%38
ping -n 1 -w 1 ::1%39
ping -n 1 -w 1 ::1%40
ping -n 1 -w 1 ::1%41
ping -n 1 -w 1 ::1%42
ping -n 1 -w 1 ::1%43
ping -n 1 -w 1 ::1%44
ping -n 1 -w 1 ::1%45
ping -n 1 -w 1 ::1%46
ping -n 1 -w 1 ::1%47
ping -n 1 -w 1 ::1%48
ping -n 1 -w 1 ::1%49
ping -n 1 -w 1 ::1%50
ping -n 1 -w 1 ::1%51
ping -n 1 -w 1 ::1%52
ping -n 1 -w 1 ::1%53
ping -n 1 -w 1 ::1%54
ping -n 1 -w 1 ::1%55
ping -n 1 -w 1 ::1%56
ping -n 1 -w 1 ::1%57
ping -n 1 -w 1 ::1%58
ping -n 1 -w 1 ::1%59
ping -n 1 -w 1 ::1%60
ping -n 1 -w 1 ::1%61
ping -n 1 -w 1 ::1%62
ping -n 1 -w 1 ::1%63
ping -n 1 -w 1 ::1%64


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Chapter 3 – IP Addressing"  |  https://docs.microsoft.com/en-us/previous-versions/tn-archive/bb726995(v=technet.10)?redirectedfrom=MSDN
#
#   serverfault.com  |  "How do I add IPv6 address into System32\drivers\etc\hosts?"  |  https://serverfault.com/questions/234711/how-do-i-add-ipv6-address-into-system32-drivers-etc-hosts
#
# ------------------------------------------------------------