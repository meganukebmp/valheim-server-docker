#!/bin/sh
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/steamuser/valheim_server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

if [ -z "$VH_SERVER_FLAGS" ]
then
	/home/steamuser/valheim_server/valheim_server.x86_64 -name "My Server" -port 2456 -world "Dedicated" -password "secret" -savedir "/home/steamuser/valheim_data"
else
	/home/steamuser/valheim_server/valheim_server.x86_64 $VH_SERVER_FLAGS
fi
# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.

export LD_LIBRARY_PATH=$templdpath
