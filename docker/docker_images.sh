#!/bin/bash



# Assume [ DISPLAY/LOG ] format when this script is called directly
IMG_FORMAT=""\
"\n        ID:  {{.ID}}"\
"\n       Tag:  {{.Repository}}:{{.Tag}}"\
"\n    Digest:  {{.Repository}}@{{.Digest}}"\
"\n   Created:  {{.CreatedSince}} on {{.CreatedAt}}"\
"\n Disk-Size:  {{.Size}}"\
"";
docker images --format "${IMG_FORMAT}" && printf "\n";


	
# --------------------------------------------------------------------------------------------------------------------------------------- #
# EXIT HERE
exit 0;
# EVERYTHING BELOW THIS LINE IS DOCUMENTATION ON HOW TO USE [ docker ps ]
# --------------------------------------------------------------------------------------------------------------------------------------- #






# DISPLAY/LOG FORMAT
#   SHOW RESULTS AS A TABLE (WITH COLUMN HEADERS)
DPS="{{.ID}}" && docker ps --format "table ${DPS}";

# FOREACH-PROCESSING FORMAT
#   SHOW RESULTS AS ROWS (for storing into a variable and walking-through with a for-each loop)
DPS="{{.ID}}" && docker ps --format "${DPS}";

# --------------------------------------------------------------------------------------------------------------------------------------- #

## ALL OPTIONS: (KEEP STATIC - DO EDITING ELSEWHERE)
## REFERENCED FROM:   https://docs.docker.com/engine/reference/commandline/ps/#formatting

# Image ID
CM="ID" && docker images --format "table {{.${CM}}}";

# Image repository
CM="Repository" && docker images --format "table {{.${CM}}}";

# Image tag
CM="Tag" && docker images --format "table {{.${CM}}}";

# Image digest
CM="Digest" && docker images --format "table {{.${CM}}}";

# Elapsed time since the image was created
CM="CreatedSince" && docker images --format "table {{.${CM}}}";

# Time when the image was created
CM="CreatedAt" && docker images --format "table {{.${CM}}}";

# Image disk size
CM="Size" && docker images --format "table {{.${CM}}}";


