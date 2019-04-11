# --------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#	EdgeOS - Shaper (QoS) - https://help.ubnt.com/hc/en-us/articles/216787288-EdgeRouter-Quality-of-Service-QoS-#6
#
#
# A more complicated policy is the shaper policy, which uses the Hierarchical Token Bucket technique to provide different bandwidth guarantees to different classes of traffic on a network link. A simple example is shown below.
#


set traffic­policy shaper shaper1 bandwidth 100mbit
set traffic­policy shaper shaper1 default bandwidth 60mbit
set traffic­policy shaper shaper1 class 2 bandwidth 20mbit
set traffic­policy shaper shaper1 class 2 match client2 ip source address 10.0.1.2/32
set traffic­policy shaper shaper1 class 3 bandwidth 20mbit
set traffic­policy shaper shaper1 class 3 match client3 ip source address 10.0.1.3/32
set interfaces ethernet eth0 traffic­policy out shaper1
commit


#
# In this example, a shaper policy shaper1 is defined and applied to the out direction on interface eth0, which has 100 Mbps bandwidth. Two classes of traffic are defined, one for traffic originating from IP address 10.0.1.2 and the other for traffic origination from IP address 10.0.1.3. Each of the two classes is guaranteed 20 Mbps of bandwidth for its traffic, meaning that when under load it guarantees that bandwidth, but can exceed it if there is availability. All other traffic falls into the default class with 60 Mbps reserved bandwidth. So, for example, if the current outgoing traffic on eth0 includes 20 Mbps from IP 10.0.1.2, 20 Mbps from IP 10.0.1.3, and 80 Mbps from other sources, the traffic from IP 10.0.1.2 and IP 10.0.1.3 will be sent out at their full rates since they are each guaranteed 20 Mbps, and the other traffic will only be sent out at 60 Mbps.
#
#
# Note: The interface mentioned in this example is eth0 (WAN). When a PPPoE interface is used for WAN, the policy should be applied to pppoeX rather than the Ethernet interface. For EdgeRouter modules that include a switch interface, the traffic policy will need to be applied to the switch interface (switch0) rather than the single Ethernet interface (eth1). 
#
