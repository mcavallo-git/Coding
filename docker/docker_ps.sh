#!/bin/bash



# Assume [ DISPLAY/LOG ] format when this script is called directly
PS_DASHES="-------------------------------------------------";
PS_FORMAT=""\
"\n${PS_DASHES}\n"\
"\n     {{.Names}}   ({{.Status}})"\
"\n          Container: {{.ID}}"\
"\n          Size:      {{.Size}}"\
"\n          Ports:     {{.Ports}}"\
"\n          Created:   {{.RunningFor}} on {{.CreatedAt}}"\
"";
docker ps -a --format "${PS_FORMAT}" && printf "\n${PS_DASHES}\n\n";


# PS_FORMAT=""\
# "-------------------------------------------------"\
# "\n    DOCKER:  {{.Names}}     (ID={{.ID}})"\
# "\n    Status:  {{.Status}}"\
# "\n     Ports:  {{.Ports}}"\
# "\n      Size:  {{.Size}}"\
# "\n   Created:  {{.RunningFor}} on {{.CreatedAt}}"\
# "";
# docker ps -a --format "${PS_FORMAT}" && printf "\n";



# --------------------------------------------------------------------------------------------------------------------------------------- #
# EXIT HERE
exit 0;
# EVERYTHING BELOW THIS LINE IS DOCUMENTATION ON HOW TO USE [ docker ps ]
# --------------------------------------------------------------------------------------------------------------------------------------- #



# DISPLAY/LOG FORMAT
#   SHOW RESULTS AS A TABLE (WITH COLUMN HEADERS)
PS_FORMAT="{{.ID}}" && docker ps --format "table ${PS_FORMAT}";

# FOREACH-PROCESSING FORMAT
#   SHOW RESULTS AS ROWS (for storing into a variable and walking-through with a for-each loop)
PS_FORMAT="{{.ID}}" && docker ps --format "${PS_FORMAT}";

# --------------------------------------------------------------------------------------------------------------------------------------- #

## ALL OPTIONS: (KEEP STATIC - DO EDITING ELSEWHERE)
## REFERENCED FROM:   https://docs.docker.com/engine/reference/commandline/ps/#formatting

# Quoted command
CM="Command" && docker ps --format "table {{.${CM}}}";

# Time when the container was created.
CM="CreatedAt" && docker ps --format "table {{.${CM}}}";

# Container ID
CM="ID" && docker ps --format "table {{.${CM}}}";

# Image ID
CM="Image" && docker ps --format "table {{.${CM}}}";

# Value of a specific label for this container. For example '{{.Label "com.docker.swarm.cpu"}}'
CM="Label" && docker ps --format "table {{.${CM}}}";

# All labels assigned to the container.
CM="Labels" && docker ps --format "table {{.${CM}}}";

# Names of the volumes mounted in this container.
CM="Mounts" && docker ps --format "table {{.${CM}}}";

# Names of the networks attached to this container.
CM="Networks" && docker ps --format "table {{.${CM}}}";

# Container names.
CM="Names" && docker ps --format "table {{.${CM}}}";

# Exposed ports.
CM="Ports" && docker ps --format "table {{.${CM}}}";

# Elapsed time since the container was started.
CM="RunningFor" && docker ps --format "table {{.${CM}}}";

# Container disk size.
CM="Size" && docker ps --format "table {{.${CM}}}";

# Container status.
CM="Status" && docker ps --format "table {{.${CM}}}";
