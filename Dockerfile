FROM ubuntu:22.04
LABEL maintainer="Debailleux, Domingo, Gomez"

RUN apt-get update && apt-get install --no-install-recommends -y 
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y imagemagick
RUN apt-get install -y curl
RUN apt-get install -y zip

WORKDIR /TPEntorno 

COPY . /TPEntorno

RUN chmod +x Menu.sh
RUN chmod +x Scripts/*.sh

CMD ["bash", "./Menu.sh"]
