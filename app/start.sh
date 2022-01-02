#!/bin/bash

# Clear Xvfb lockfile
rm -f /tmp/.X0-lock

# Start Xvfb so that TWS/IBGateway will run
Xvfb :0 -ac -screen 0 1920x1080x24 &

export DISPLAY=:0

# Start VNC server, listening at 5900 by default
x11vnc -ncache 10 -ncache_cr -viewpasswd remote_view_only_pass -passwd some_pass123  -display :0 -forever -shared -bg -noipv6 &

# Start TWS and automatically restart if it dies
while true; do
    /opt/ibc/twsstart.sh -inline
    sleep 5
done

