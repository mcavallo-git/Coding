# ------------------------------------------------------------
#
# EdgeOS - Shaper (QoS)
#
#   A more complicated policy is the shaper policy, which uses the Hierarchical Token Bucket
#     technique to provide different bandwidth guarantees to different classes of traffic on a network link.
#
#   A simple example is shown below.
#

configure
set traffic-policy shaper shaper1 bandwidth 100mbit
set traffic-policy shaper shaper1 default bandwidth 60mbit
set traffic-policy shaper shaper1 class 2 bandwidth 20mbit
set traffic-policy shaper shaper1 class 2 match client2 ip source address 10.0.1.2/32
set traffic-policy shaper shaper1 class 3 bandwidth 20mbit
set traffic-policy shaper shaper1 class 3 match client3 ip source address 10.0.1.3/32
set interfaces ethernet eth0 traffic-­policy out shaper1
commit ; save
exit

#
#   In this example, a shaper policy shaper1 is defined and applied to the out direction on interface eth0, which has 100 Mbps bandwidth.
#
#   Two classes of traffic are defined, one for traffic originating from IP address 10.0.1.2
#     and the other for traffic origination from IP address 10.0.1.3.
#
#   Each of the two classes is guaranteed 20 Mbps of bandwidth for its traffic, meaning
#     that when under load it guarantees that bandwidth, but can exceed it if there is availability.
#
#   All other traffic falls into the default class with 60 Mbps reserved bandwidth.
#
#   So, for example, if the current outgoing traffic on eth0 includes:
#     20 Mbps from IP 10.0.1.2,
#     20 Mbps from IP 10.0.1.3, and
#     80 Mbps from other sources,
#   the traffic from IP 10.0.1.2 and IP 10.0.1.3 will be sent out at their full rates since
#   they are each guaranteed 20 Mbps, and the other traffic will only be sent out at 60 Mbps.
#
# Note:
#
#   The interface mentioned in this example is eth0 (WAN).
#
#   When a PPPoE interface is used for WAN, the policy should be applied to pppoeX rather than the Ethernet interface.
#
#   For EdgeRouter modules that include a switch interface, the traffic policy will need
#     to be applied to the switch interface (switch0) rather than the single Ethernet interface (eth1).
#


# ------------------------------------------------------------
#
# EdgeRouter - Traffic Policies (Shaper) for Upload, Download and VoIP (QoS)
#
#   The following example uses two traffic policies (one for upload, one for
#     download) to limit client 10.0.3.2 to an upload rate of 512Kbps (allowing bursts to 640Kbps)
#     and downloads of 1Mbit (allowing bursts to 1.5Mbit if the bandwidth is available).
#

# DOWNLOAD SHAPER
configure
set traffic-policy shaper client-down bandwidth '1000mbit'
set traffic-policy shaper client-down class 2 bandwidth '1mbit'
set traffic-policy shaper client-down class 2 burst '1k'
set traffic-policy shaper client-down class 2 ceiling '1.5mbit'
set traffic-policy shaper client-down class 2 match ADDR ip destination address '10.0.3.2/32'
set traffic-policy shaper client-down class 2 queue-type 'fair-queue'
set traffic-policy shaper client-down class 3 bandwidth '1mbit'
set traffic-policy shaper client-down class 3 burst '1k'
set traffic-policy shaper client-down class 3 ceiling '1.5mbit'
set traffic-policy shaper client-down class 3 match ADDR ip destination address '10.0.3.3/32'
set traffic-policy shaper client-down class 3 queue-type 'fair-queue'
set traffic-policy shaper client-down default bandwidth '100%'
set traffic-policy shaper client-down default burst '1k'
set traffic-policy shaper client-down default ceiling '100%'
set traffic-policy shaper client-down default queue-type 'fair-queue'
set interfaces ethernet eth1 traffic-policy out 'client-down'
commit ; save
exit



# UPLOAD SHAPER
#   Note:  One class is for each client
configure
set traffic-policy limiter client-up class 1 bandwidth '512kbit'
set traffic-policy limiter client-up class 1 burst '1mb'
set traffic-policy limiter client-up class 1 match ADDR ip source address '10.0.3.2/32'
set traffic-policy limiter client-up default bandwidth '1000mbit'
set interfaces ethernet eth1 traffic-policy in 'client-up'
commit ; save
exit


# ------------------------------------------------------------
#
# Example 2  -  https://cloudbrothers.info/en/optimize-your-microsoft-teams-traffic-with-qos-on-a-unifi-usg/
#

# Configure mode on USG
# Connect via SSH to your UniFi router and enter the “configure” mode

configure

#
# Upload traffic shaping
# The following commands setup a traffic shaping policy that distributes the 50 Mbit upload speed between four different traffic classes.
# It guarantees the specified percentage of the total upload bandwidth (50Mbps) to those classes but because of the “ceiling” value of 100% is does not restrict the traffic to this percentage. So after you finish work you are not restricted to only 70% of the total upload speed, but can use it all.
#
# Policy class         Guaranteed bandwidth %   Max bandwidth %
# Default              70                       100
# 10 (Voice)           15                       100
# 20 (Video)           8                        100
# 30 (Screensharing)   7                        100
#

set traffic-policy shaper upload description "Microsoft Teams QoS"

set traffic-policy shaper upload bandwidth 50mbit
set traffic-policy shaper upload default bandwidth 70%
set traffic-policy shaper upload default ceiling 100%

set traffic-policy shaper upload class 10 bandwidth 15%
set traffic-policy shaper upload class 10 ceiling 100%
set traffic-policy shaper upload class 10 match rtp ip dscp 46

set traffic-policy shaper upload class 20 bandwidth 8%
set traffic-policy shaper upload class 20 ceiling 100%
set traffic-policy shaper upload class 20 match sip ip dscp 34

set traffic-policy shaper upload class 30 bandwidth 7%
set traffic-policy shaper upload class 30 ceiling 100%
set traffic-policy shaper upload class 30 match sip ip dscp 18

# Apply and save configuration
# After you have setup the configuration, you will need to activate and safe it.

set interfaces ethernet eth0 traffic-policy out upload
commit ; save ; exit

#
# Export config as JSON
# If you are using the USG the configuration would be overwritten the next time you are changing something on the UniFi controller. To avoid this you have to use a file called config.gateway.json. Please refer to the linked articel to setup this file on your UniFi controller.
#
# You can use the following command to dump the complete configuration and extract the parts you need.
#

mca-ctrl -t dump-cfg
#
# Or you could use this amazing script that Daniil Baturin wrote to only extract the part of the config you really need.
#
./usg-config-export.py "interfaces ethernet eth0 traffic-policy" "traffic-policy"

# config.gateway.json and Docker
# If your UniFi controller is running as a docker container and your site name is “default” add the following to you docker-compose file.

volumes:
  - /path/to/persitent/config/unifi/config.gateway.json:/unifi/data/sites/default/config.gateway.json



# ------------------------------------------------------------
#
#   Citation(s)
#
#   cloudbrothers.info  |  "Optimize your Microsoft Teams traffic with QoS on a UniFi USG - Cloudbrothers"  |  https://cloudbrothers.info/en/optimize-your-microsoft-teams-traffic-with-qos-on-a-unifi-usg/
#
#   community.ui.com  |  "Another QoS related question"  |  https://community.ui.com/questions/Another-QoS-related-question/3b1dbec9-b790-4ce6-a47d-fbf98c0a00b4#answer/aca3d12e-e8a6-4594-9d7d-367b3dc9f035
#
#   community.ui.com  |  "Smart Queue Mngmt: Advanced options recommendations for online-GAMING. | Ubiquiti Community"  |  https://community.ui.com/questions/Smart-Queue-Mngmt-Advanced-options-recommendations-for-online-GAMING-/591c2514-15dc-405f-bd85-3f82015bbe4c
#
#   help.ubnt.com  |  "EdgeRouter - Quality of Service (QoS)"  |  https://help.ubnt.com/hc/en-us/articles/216787288-EdgeRouter-Quality-of-Service-QoS-#6
#
#   help.ubnt.com  |  "EdgeRouter - Quality of Service (QoS) Shaper for Upload/Download and VoIP"  |  https://help.ubnt.com/hc/en-us/articles/204911404-EdgeRouter-Traffic-Policies-Shaper-for-Upload-Download-and-VoIP
#
# ------------------------------------------------------------