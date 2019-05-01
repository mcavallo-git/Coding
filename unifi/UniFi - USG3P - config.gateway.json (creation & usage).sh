
# ------------------------------------------------------------
#
# Show current USG-3P config in JSON format:

# - SSH into USG-3P device & run the following command:
mca-ctrl -t dump-cfg



# ------------------------------------------------------------
#
# Apply aftermarket config(s) not availble on Unifi dashboard:


# - SSH into linux machine hosting the unifi controller

# - Create and/or make-edits-to your unifi site's "config.gateway.json" file, located at:
vi "/usr/lib/unifi/data/sites/default/config.gateway.json";

# - Re-provision the USG-3p on the unifi dashboard under "Devices" -> USG-3P -> "Manage" (cog) -> "Provision"



# ------------------------------------------------------------
