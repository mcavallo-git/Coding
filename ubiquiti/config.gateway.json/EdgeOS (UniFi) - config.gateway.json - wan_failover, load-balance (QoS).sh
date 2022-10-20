#!/bin/vbash
# ------------------------------------------------------------
# EdgeOS (UniFi) - QoS - load-balance, wan_failover.sh
# ------------------------------------------------------------


show load-balance watchdog;


show load-balance status;


# Create a longstanding shortcut from the user login directory to the config.gateway.json directory
if [ "$(realpath "/root/site-config.gateway.json";)" != "/srv/unifi/data/sites/default" ]; then ln -sf "/srv/unifi/data/sites/default" "${HOME}/site-config.gateway.json"; fi;


# ------------------------------
#
# Decent config.gateway.json config for failover
#
# {
#   "load-balance": {
#     "group": {
#       "wan_failover": {
#         "flush-on-active": "disable", # 'enable' kills active connections when failing back (useful if failover modem is a 4g/5g/metered modem)
#         "interface": {
#           "eth0": {
#             "route-test": {
#               "count": {
#                 "failure": "3",       # how many "failed" tests are required to mark the connection as down
#                 "success": "3"        # how many "good" tests are required to flip back to this connection
#               },
#               "initial-delay": "5",
#               "interval": "3",        # how often to ping test the target, in seconds
#               "type": {
#                 "ping": {
#                   "target": "8.8.8.8"
#                 }
#               }
#             }
#           },
#           "eth2": {
#             "failover-only": "''",
#             "route-test": {
#               "count": {
#                 "failure": "3",       # how many "failed" tests are required to mark the connection as down
#                 "success": "3"        # how many "good" tests are required to flip back to this connection
#               },
#               "initial-delay": "5",
#               "interval": "3",        # how often to ping test the target, in seconds
#               "type": {
#                 "ping": {
#                   "target": "8.8.8.8"
#                 }
#               }
#             }
#           }
#         },
#         "sticky": {
#           "dest-addr": "enable",
#           "dest-port": "enable",
#           "source-addr": "enable"
#         },
#         "transition-script": "/config/scripts/wan-event-report.sh"
#       }
#     }
#   }
# }
#
#
# ------------------------------
#
# Default wan_failover UniFi configuration, settable in [ /srv/unifi/data/sites/default/config.gateway.json ]
#
# {
#   "load-balance": {
#     "group": {
#       "wan_failover": {
#         "interface": {
#           "eth0": {
#             "route-test": {
#               "initial-delay": "20",
#               "interval": "10"
#             }
#           },
#           "eth2": {
#             "failover-only": "''",
#             "route-test": {
#               "initial-delay": "20",
#               "interval": "10"
#             }
#           }
#         },
#         "sticky": {
#           "dest-addr": "enable",
#           "dest-port": "enable",
#           "source-addr": "enable"
#         },
#         "transition-script": "/config/scripts/wan-event-report.sh"
#       }
#     }
#   }
# }
#
#
# ------------------------------------------------------------
#
# WAN failback config
#
# {
#   "load-balance": {
#     "group": {
#       "wan_failover": {
#         "flush-on-active": "enable"
#       }
#     }
#   }
# }
#
#
# ------------------------------------------------------------
#
# WAN failback config
#
# {
#   "load-balance": {
#     "group": {
#       "wan_failover": {
#         "flush-on-active": "enable"
#       }
#     }
#   }
# }
#
#
# ------------------------------------------------------------
#
#   Citation(s)
#
#   community.ui.com  |  "faster failover time | Ubiquiti Community"  |  https://community.ui.com/questions/faster-failover-time/e0bdfce1-9c4d-4fa4-8439-cff4734d40a4
#
#   community.ui.com  |  "USG Failback broken - does not clear Established connections when WAN1 restored | Ubiquiti Community"  |  https://community.ui.com/questions/USG-Failback-broken-does-not-clear-Established-connections-when-WAN1-restored/aef105b7-9801-4d45-83ff-9f8ff72a1814#answer/cae917dd-ffba-4cd4-89e2-261fead040f7
#
#   scotthelme.co.uk  |  "Stabilising failover detection on the Unifi Security Gateway"  |  https://scotthelme.co.uk/stabilising-failover-detection-on-the-usg/
#
# ------------------------------------------------------------