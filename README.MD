# Valheim Server Docker
This is a simple lightweight valheim dedicated server container based on **Ubuntu 18.04**.

## Configuration
Configure the server name, password and other parameters in `entrypoint.sh` before building.

## Building
Building this image requires no special parameters
```sh
docker build -t <imagename> <path>
```

## Deployment
The container uses a volume for worlds and configuration data at `/home/steamuser/valheim_data`. Make sure `steamuser` has RW permissions, otherwise the server will fail to launch.

The container needs UDP port range `2456-2458` to be open and forwarded.

To deploy the container run
```sh
docker run -t -d \
-p 2456-2458:2456-2458/udp \
-u steamuser \
-v <datavolume/path>:/home/steamuser/valheim_data \
--name <container name> \
<imagename>
```

## Connecting
If your server was configured correctly you should be able to find it in the ingame server browser. [If not, add it to steam favorites](http://survivalservers.com/wiki/index.php?title=Steam_Server_Favorites) **with port number + 1** (*example: if your server was configured to run on 2456, you must use 2457*)