FROM nvidia/cuda:12.3.1-runtime-ubuntu22.04

# update and upgrade
RUN apt-get update && apt-get upgrade -y

#install python3, pip and venv
RUN apt-get install -y bash git python3 pip
RUN apt-get install -y libicu-dev

WORKDIR /app
RUN git clone https://github.com/Stability-AI/StableSwarmUI

WORKDIR /app/StableSwarmUI/launchtools

RUN apt-get install -y wget
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
RUN chmod +x dotnet-install.sh

RUN bash ./dotnet-install.sh --channel 7.0

#needed when stableswarm changes to that runtime
#leave until then, as it doubles the image size
#RUN bash ./dotnet-install.sh --channel 8.0

WORKDIR /app/StableSwarmUI/dlbackend
RUN git clone https://github.com/comfyanonymous/ComfyUI


#copy local Settings.fds to the container
COPY ./Settings.fds /app/StableSwarmUI/Data/Settings.fds


#launch the UI when the container starts
ENTRYPOINT ["/app/StableSwarmUI/launch-linux.sh"]