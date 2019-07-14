# ------------------------------------------------------------
#
#	EdgeOS - Fair Queue (QoS)
#
#		The fair queue policy uses the Stochastic Fairness Queueing approach to separate traffic
#			flows (for example, TCP connections) into different buckets and have the router service each bucket one by one.
#
#		The separation is done using a hash of the source/destination IP addresses and the source port.
#
#		Probabilistically this allows the router to fairly service different traffic flows.
#
#
#		The fair queue policy can only be applied to the out direction.
#
#		Since the fairness is probabilistic, in some cases multiple flows may be put into the same bucket; this can potentially cause unfairness.
#
#		To minimize effects, you can adjust the hash interval parameter to change the hashing algorithm at fixed time intervals.
#


#		This is an example of a fair queue policy:
configure
set traffic-policy fair-queue fair1 hash-interval 10
set interfaces ethernet eth0 traffic-policy out fair1
commit; save

#
#	Note:
#		The interface mentioned in this example is eth0 (WAN).
#
#		When a PPPoE interface is used for WAN, the policy should be applied to pppoeX rather than the Ethernet interface.
#
#		For EdgeRouter modules that include a switch interface, the traffic policy will need to be
#			applied to the switch interface (switch0) rather than the single Ethernet interface (eth1). 
#



# ------------------------------------------------------------
#
#		Citation(s)
#
#		https://help.ubnt.com/hc/en-us/articles/216787288-EdgeRouter-Quality-of-Service-QoS-#5
#
# ------------------------------------------------------------