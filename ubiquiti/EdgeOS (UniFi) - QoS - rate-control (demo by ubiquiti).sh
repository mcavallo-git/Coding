# ------------------------------------------------------------
#
# EdgeOS - Rate Control (QoS)
#
#   The rate-control policy aims to ensure that the traffic is transmitted at no more than a pre-defined rate.
#
#   It can be applied to the out direction, and the main parameter is the maximum rate for the outgoing traffic.
#
#   For example, the following CLI commands create a rate-control policy that will attempt
#     to ensure that the outgoing traffic is transmitted at no more than 1 Mbps on interface eth0.
#

configure
set traffic-policy rate-control rate1 bandwidth 1mbit
set interfaces ethernet eth0 traffic-policy out rate1
commit ; save
exit

#
# Note:
#   The interface mentioned in this example is eth0 (WAN).
#
#   When a PPPoE interface is used for WAN, the policy should be applied to pppoeX rather than the Ethernet interface.
#
#   For EdgeRouter modules that include a switch interface, the traffic policy will need to
#     be applied to the switch interface (switch0) rather than the single Ethernet interface (eth1).
#



# ------------------------------------------------------------
#
#   Citation(s)
#
#   https://help.ubnt.com/hc/en-us/articles/216787288-EdgeRouter-Quality-of-Service-QoS-#rate
#
# ------------------------------------------------------------