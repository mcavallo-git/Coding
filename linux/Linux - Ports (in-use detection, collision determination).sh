
# List ports in use
lsof -i -P -n | grep 'LISTEN';

# Show all items using port 443
fuser -k 443/tcp;

# Kill all items using port 443
fuser -k 443/tcp;

# Compare running-processes to actively-listening ports for any process containing the name [ java ]
watch -n 1 echo "$(echo '' && ps aux | grep '%MEM' && ps aux | grep 'java' && echo '' && lsof -i -P -n | grep 'SIZE/OFF' && lsof -i -P -n | grep 'LISTEN' | grep 'java' && echo '')";