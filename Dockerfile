FROM ubuntu:wily-20151009

RUN apt-get install -y wget vim curl

RUN wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | apt-key add -
RUN echo "deb     http://repos.sensuapp.org/apt sensu main" | tee /etc/apt/sources.list.d/sensu.list

RUN apt-get update
RUN apt-get install -y sensu=0.20.3-1

ADD ops/docker-files/etc/sensu /etc/sensu
ADD ops/docker-files/run.sh /opt/run.sh

RUN chown -R sensu:sensu /etc/sensu

