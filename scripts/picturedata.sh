#!/bin/bash
echo "Changes image file names, moves to the right folders and updates pictures.yaml"


cd "${0%/*}"
cd ..

echo "Changing file names..."
cd content
exiftool ./ '-filename<DateTimeOriginal' -d %Y%m%d-%H%M%S%%-c.%%le -r

echo "adjusting quality"
cd ..
cd scripts
./compress_all_pictures.sh "../content/posts/" 1

echo "Moving to the right folders..."
python picture_operations.py


echo "Build tsv..."
cd ../content

echo -e "directory\tfile\tdatetime\ttitle\tdescription\tlatitude\tlongitude" > ../data/pictures.tsv
exiftool ./ -R -E -T -n -directory -filename -datetimeoriginal -title -description -gpslatitude -gpslongitude >> ../data/pictures.tsv

echo "Transform to yaml"

cd ..
python scripts/csv_to_yaml.py

rm data/pictures.tsv

echo Done
