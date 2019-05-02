
# <intIP> = The IP of the interface you want to listen for SNMP traffic
# <snmpPort> = The port to use (UDP)
# <viewName> = arbitrary name of a View object
# <engineId> = Hex-value engine ID, e.g. 0xaaaa
# <groupName> = arbitrary name of a Group object
# <userName> = arbitrary name of a User object
# <authKey> = a long, complex key used for authentication
# <encKey> = a long, complex key used for encryption (key should be separate from authKey!)



set service snmp listen-address <intIP> port <snmpPort>
set service snmp v3 view <viewName>
set service snmp v3 view <viewName> oid 1
set service snmp v3 engineid <engineId>
set service snmp v3 group <groupName>
set service snmp v3 group <groupName> mode ro
set service snmp v3 group <groupName> seclevel priv
set service snmp v3 group <groupName> view <viewName>
set service snmp v3 user <userName> auth plaintext-key <authKey> 
set service snmp v3 user <userName> auth type sha
set service snmp v3 user <userName> engineid <engineId>
set service snmp v3 user <userName> group <groupName>
set service snmp v3 user <userName> mode ro
set service snmp v3 user <userName> privacy plaintext-key <encKey>
set service snmp v3 user <userName> privacy type aes


#
#	Citation(s)
#
#	Thanks to site: https://vext.info/2017/10/08/configuring-snmp-v3-on-ubiquiti-edgerouter-x.html
#
