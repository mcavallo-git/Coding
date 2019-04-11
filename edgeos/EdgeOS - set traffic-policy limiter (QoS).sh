# --------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#	EdgeOS - Limiter (QoS) - https://help.ubnt.com/hc/en-us/articles/216787288-EdgeRouter-Quality-of-Service-QoS-#7
#
#
# The limiter policy performs ingress policing and therefore can only be applied to the in direction of traffic on a network interface. You can define multiple classes of traffic, and you can apply a separate bandwidth limit to each class. For example, the following policy set a limit of 1 Mbps for incoming ICMP traffic on eth0 and a limit of 10 Mbps for the other traffic.
#


configure
set traffic-­policy limiter limit1 class 1 bandwidth 1mbit
set traffic-­policy limiter limit1 class 1 match match1 ip protocol icmp
set traffic-­policy limiter limit1 default bandwidth 10mbit
set interfaces ethernet eth0 traffic­policy in limit1
commit 


#
# Note: The limiter policy is designed for traffic destined for the router itself, and the policing behavior is less accurate when it is applied to traffic that is going through the router. One possible workaround for this is to create an input interface, to which any outbound policies can be then applied.
#
# Note: The interface mentioned in this example is eth0 (WAN). When a PPPoE interface is used for WAN, the policy should be applied to pppoeX rather than the Ethernet interface. For EdgeRouter modules that include a switch interface, the traffic policy will need to be applied to the switch interface (switch0) rather than the single Ethernet interface (eth1). 
#
