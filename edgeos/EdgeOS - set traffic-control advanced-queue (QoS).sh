# --------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#	EdgeOS - Advanced Queue'ing (QoS) - https://help.ubnt.com/hc/en-us/articles/220716608-EdgeRouter-Advanced-Queue-CLI-Examples
#
#		"Follow these steps to limit the rate for one LAN device and file-transfer application. Use HFQ (Host Fairness Queueing) to explicitly and automatically limit the rate for each of the devices in the configured subnet. Allow burst for file-transfer traffic in a short time."
#


# 1. Enter configuration mode.
configure


# 2. Create a root queue 1 on "global".
set traffic-control advanced-queue root queue 1 attach-to global
set traffic-control advanced-queue root queue 1 bandwidth 100mbit


# 3. Create branch queue 100 for upload and queue 200 for download.
set traffic-control advanced-queue branch queue 100 bandwidth 10mbit
set traffic-control advanced-queue branch queue 100 description Upload
set traffic-control advanced-queue branch queue 100 parent 1
set traffic-control advanced-queue branch queue 200 bandwidth 30mbit
set traffic-control advanced-queue branch queue 200 description Download
set traffic-control advanced-queue branch queue 200 parent 1


# 4. Create filters on root queue 1 to filter upload and download traffic to branch queue 100 and 200.
set traffic-control advanced-queue filters match 100 attach-to 1
set traffic-control advanced-queue filters match 100 description 'WAN upload'
set traffic-control advanced-queue filters match 100 ip source address 192.168.2.0/24
set traffic-control advanced-queue filters match 100 target 100
set traffic-control advanced-queue filters match 200 attach-to 1
set traffic-control advanced-queue filters match 200 description 'WAN download'
set traffic-control advanced-queue filters match 200 ip destination address 192.168.2.0/24
set traffic-control advanced-queue filters match 200 target 200


# 5. Create FQ_CODEL queue types for later use on leaf queues.
set traffic-control advanced-queue queue-type fq-codel FQCODEL_DOWN
set traffic-control advanced-queue queue-type fq-codel FQCODEL_UP


# 6. Create leaf queue 199 to limit default upload traffic and queue 299 to limit default download traffic. Both of the leaf queue use FQ_CODEL as their queueing method.
set traffic-control advanced-queue leaf queue 199 bandwidth 10mbit
set traffic-control advanced-queue leaf queue 199 description default
set traffic-control advanced-queue leaf queue 199 parent 100
set traffic-control advanced-queue leaf queue 199 queue-type FQCODEL_UP
set traffic-control advanced-queue leaf queue 299 bandwidth 30mbit
set traffic-control advanced-queue leaf queue 299 description default
set traffic-control advanced-queue leaf queue 299 parent 200
set traffic-control advanced-queue leaf queue 299 queue-type FQCODEL_DOWN


# 7. Create a default filter on branch queue 100 to filter traffic to queue 199 and a default filter on branch queue 200 to filter traffic to queue 299.
set traffic-control advanced-queue filters match 199 attach-to 100
set traffic-control advanced-queue filters match 199 description Default
set traffic-control advanced-queue filters match 199 target 199
set traffic-control advanced-queue filters match 299 attach-to 200
set traffic-control advanced-queue filters match 299 description Default
set traffic-control advanced-queue filters match 299 target 299


# 8. Commit the changes and save the configuration.
commit ; save


# --------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#		Other Guide(s):
#
#		https://help.ubnt.com/hc/en-us/articles/216787288-EdgeRouter-Quality-of-Service-QoS-#5
#
#		https://help.ubnt.com/hc/en-us/articles/205198380-EdgeRouter-Quality-of-Service-for-Voice-Over-IP-QoS-for-VoIP-
#
#		https://community.ubnt.com/t5/EdgeRouter/Help-with-QOS-please/td-p/1764847
#
#		https://blog.gruby.com/2015/08/25/setting-up-qos-on-the-edge-router-lite/
#
#
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------