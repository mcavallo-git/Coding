DIRECTORY="/home/boneal/public_html";
find ${DIRECTORY} -type d -print0 | xargs -0 chmod 0775; # for directories
find ${DIRECTORY} -type f -print0 | xargs -0 chmod 0664; # for files
