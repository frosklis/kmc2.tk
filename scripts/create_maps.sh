CUR="$(pwd)"
DIR=`dirname "$0"`
echo $DIR
cd "$DIR"

regiones=$( python create_maps.py )
echo $regiones

cd ../data-src

ogr2ogr \
  -f GeoJSON \
  -where "ISO_3166_2 IN (${regiones})" \
  provincias_mundo.temp.json \
  ne_10m_admin_1_states_provinces.shp

# pasar a topojson
topojson \
  -o provincias_mundo.json \
  --id-property iso_3166_2 \
  -- \
  provincias_mundo.temp.json

cp provincias_mundo.json ../static/
rm provincias_mundo.temp.json

cd "$CUR"
