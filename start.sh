#!/bin/bash -ex
# Start script for Dedciated Server

if [ ${BRANCH} == public ]
then
	# GA Branch
	/steamcmd/steamcmd.sh +login anonymous +force_install_dir /empyrion +app_update 530870 +quit
else
	# used specified branch
	/steamcmd/steamcmd.sh +login anonymous +force_install_dir /empyrion +app_update 530870 -beta ${BRANCH} +quit
fi

rm -f /tmp/.X1-lock
Xvfb :1 -screen 0 800x600x24 &
export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:1

# Does a YAML for the instance exist?
if [ ! -f /empyrion/dedicated_${INSTANCE_NAME}.yaml ]
then
	# No, copy for edit
	cp /empyrion/dedicated.yaml /empyrion/dedicated_${INSTANCE_NAME}.yaml
fi

cd /empyrion/DedicatedServer

sh -c 'until [ "`netstat -ntl | tail -n+3`" ]; do sleep 1; done
sleep 5 # gotta wait for it to open a logfile
tail -F ../logs/current.log ../logs/*/*.log 2>/dev/null' &
/opt/wine-staging/bin/wine ./EmpyrionDedicated.exe -batchmode -logFile ../logs/current.log -dedicated ../dedicated_${INSTANCE_NAME}.yaml "$@" &> /empyrion/logs/wine.log