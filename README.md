# cryofall-server
Docker Image for Empyrion Dedicated Server

Build to create a containerized version of Empyrion - Galactic Survival
https://store.steampowered.com/app/383120/Empyrion__Galactic_Survival/
 
Build by hand
```
git clone https://github.com/antimodes201/empyrion-server.git
docker build -t antimodes201/empyrion-server:latest .
```
 
Docker pull
```
docker pull antimodes201/empyrion-server
```
 
Some notes.  The server package was built for windows and as such this distribution is based on wine.  This comes with my standard disclaimer that you might run into oddities / strange behaviour because of this.
Run the server once to download and created the default config.  Afterwards shut down the instance and edit the dedicated config.  The server will use a custom dedicated YAML based on your INSTANCE_NAME.  This is to prevent the config from being wiped between updates.

Docker Run with defaults
change the volume options to a directory on your node and maybe use a different name then the one in the example
```
docker run -it -p 30000-30004:30000-30004/udp -p 30000-30004:30000-30004 -v /app/docker/temp-vol:/empyrion \
	-e INSTANCE_NAME="t3stn3t" \
	--name empyrion \
	antimodes201/empyrion-server:latest

```
 
Currently exposed environmental variables and their default values
- BRANCH "public"
- INSTANCE_NAME "default"
- TZ "America/New_York"