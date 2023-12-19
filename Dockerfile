FROM postgres:16.1

RUN apt-get update && apt-get install -y wget unzip postgis
