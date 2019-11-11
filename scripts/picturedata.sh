cd ..
cd content
exiftool ./ '-filename<CreateDate' -d %Y%m%d-%H%M%S%%-c.%%le -r
echo -e "directory\tfile\tdatetime\ttitle\tdescription\tlatitude\tlongitude" > ../data-src/pictures.tsv
exiftool ./ -R -E -T -n -directory -filename -datetimeoriginal -title -description -gpslatitude -gpslongitude >> ../data-src/pictures.tsv
