TABLE_NAME="domainlist";
DB_FILEPATH="/etc/pihole/gravity.db";
DOCKER_NAME="pihole"; docker exec "$(docker ps --all --quiet --filter "name=${DOCKER_NAME}";)" sqlite3 "${DB_FILEPATH}" ".schema ${TABLE_NAME}";