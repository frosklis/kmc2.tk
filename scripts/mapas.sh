# https://medium.com/@mbostock/command-line-cartography-part-1-897aa8f8ca2c

ogr2ogr \
  -f GeoJSON \
  -where "ISO_A2 IN ('ES')" \
  provincias_esp.json \
  ne_10m_admin_1_states_provinces.shp

# Convertir shp a json
shp2json ne_10m_admin_1_states_provinces.shp -o provincias.json
shp2json -n ne_10m_admin_1_states_provinces.shp | ndjson-filter 'd.properties.iso_a2 == "ES"' > provincias_esp.ndjson
# 'd.geometry.type === "MultiPolygon"'
# geoproject 'd3.geoConicEqualArea().parallels([34, 40.5]).rotate([120, 0]).fitSize([960, 960], d)'

# Elegir una proyección 
geoproject 'd3.geoMercator().fitSize([960, 960], d)' < provincias.json > provincias_mercator.json

# Convertir a svg
geo2svg -w 960 -h 960 < provincias_mercator.json > provincias_mercator.svg

# Por líneas
ndjson-split 'd.features' < provincias.json > provincias.ndjson
# Filtramos España
ndjson-filter 'd.properties.iso_a2 == "ES"' < provincias.ndjson > provincias_esp.ndjson

# Añadir un id
ndjson-map 'd.id = d.properties.iso_a2, d' < provincias_esp.ndjson > provincias_esp_id.ndjson

topojson \
  -o provincias_esp_id.json \
  --id-property iso_3166_2 \
  -- \
  provincias_esp.json

geoproject 'd3.geoMercator().fitSize([960, 960], d)' < provincias_esp.json > provincias_mercator_esp.json

geo2svg -w 960 -h 960 < provincias_mercator_esp.json > provincias_mercator_esp.svg
