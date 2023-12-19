#!/bin/sh

# Make working directory
mkdir /tmp/work && cd /tmp/work

# Create postgis extension
psql -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE EXTENSION postgis"

# Get data from website
wget https://nlftp.mlit.go.jp/ksj/gml/data/P30/P30-13/P30-13_40.zip
unzip P30-13_40.zip

# Convert to SQL
shp2pgsql -W cp932 -D -I -s 4612:4326 ./P30-13_40/P30-13_40.shp > ./init.sql

# Execute SQL to import data
psql -U $POSTGRES_USER -d $POSTGRES_DB -f ./init.sql

# Remove working directory
cd / && rm -rf /tmp/work
