FROM --platform=linux/x86_64 debian:9

ENV debian-frontend=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
       # VNC server and display
       xvfb \ 
       x11vnc \ 
       metacity \
       # download IBC and TWS
       unzip \
       wget 

# Download and install offline version of TWS
RUN wget https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh -O install.sh \
    && chmod +x install.sh \
    && yes '' | ./install.sh \
    && rm install.sh

# Install the specified version of IBC
ARG ibc_version=3.12.0
RUN wget https://github.com/IbcAlpha/IBC/releases/download/$ibc_version/IBCLinux-$ibc_version.zip -O ibc.zip \
    && unzip ibc.zip -d /opt/ibc \
    && rm ibc.zip


# Set permissions of ibc scripts
COPY twsstart.sh /opt/ibc/
COPY displaybannerandlaunch.sh /opt/ibc/scripts/
RUN chmod +x /opt/ibc/*.sh /opt/ibc/scripts/*.sh

# start
COPY start.sh .
RUN chmod +x ./start.sh
CMD [ "./start.sh" ]
