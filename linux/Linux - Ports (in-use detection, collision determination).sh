
# List ports in use
lsof -i -P -n | grep LISTEN

# Show all items using port 443
fuser -k 443/tcp

# Kill all items using port 443
fuser -k 443/tcp
