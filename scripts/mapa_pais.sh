#!/bin/bash
# https://medium.com/@mbostock/command-line-cartography-part-1-897aa8f8ca2c
cur="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"
cd ../data-src

echo `ls`

ogr2ogr \
  -f GeoJSON \
  -where "ISO_A2 IN ('$1')" \
  provincias_$1.temp.json \
  ne_10m_admin_1_states_provinces.shp

# pasar a topojson
topojson \
  -o provincias_$1.json \
  --id-property iso_3166_2 \
  -- \
  provincias_$1.temp.json

rm provincias_$1.temp.json
cd $cur
