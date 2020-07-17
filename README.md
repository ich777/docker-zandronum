# Zandronum Server in Docker optimized for Unraid
This Docker will download and install Zandronum Server and run it.

Zandronum brings classic Doom into the 21st century, maintaining the essence of what has made Doom great for so many years and, at the same time, adding new features to modernize it, creating a fresh, fun new experience.

ATTENTION: You have to place your wad files into the '/wads' folder to complete the startup of the server (If you place more than one wad file in the folder you have to append the GAME_PARAMS with for example: '-iwad DOOM2.WAD' - without quotes - to load like in this example DOOM2, also note that the wad file is case sensitive).


## Env params
| Name | Value | Example |
| --- | --- | --- |
| GAME_PARAMS | Startup game parameters | -port 10666 +exec server.cfg |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |

## Run example
```
docker run --name Zandronum -d \
	-p 10666:10666/udp \
	--env 'GAME_PARAMS=-port 10666 +exec server.cfg' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /mnt/cache/appdata/zandronum:/zandronum \
	ich777/zandronum
```


This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/