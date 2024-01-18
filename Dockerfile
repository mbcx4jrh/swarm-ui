FROM alpine

# update and upgrade
RUN apk update && apk upgrade

#install python3, pip and venv
RUN apk add --no-cache bash git python3 py3-pip
RUN apk add --no-cache icu-libs

RUN git clone https://github.com/Stability-AI/StableSwarmUI

RUN cd StableSwarmUI/launchtools

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
RUN chmod +x dotnet-install.sh

RUN bash ./dotnet-install.sh --channel 7.0

#needed when stableswarm changes to that runtime
#RUN bash ./dotnet-install.sh --channel 8.0

RUN cd ..

#copy local Settings.fds to the container
COPY ./Settings.fds ./StableSwarmUI/Data/Settings.fds


#launch the UI when the container starts
CMD ["bash", "./StableSwarmUI/launch-linux.sh"]