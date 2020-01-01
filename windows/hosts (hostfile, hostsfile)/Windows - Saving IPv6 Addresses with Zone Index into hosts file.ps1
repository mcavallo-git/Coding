

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


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Chapter 3 – IP Addressing"  |  https://docs.microsoft.com/en-us/previous-versions/tn-archive/bb726995(v=technet.10)?redirectedfrom=MSDN
#
#   serverfault.com  |  "How do I add IPv6 address into System32\drivers\etc\hosts?"  |  https://serverfault.com/questions/234711/how-do-i-add-ipv6-address-into-system32-drivers-etc-hosts
#
# ------------------------------------------------------------