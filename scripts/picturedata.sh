

cd /Users/claudio/Dropbox/webs/www.kmc2.tk/
cd content
echo -e "directory\tfile\tdatetime\ttitle\tdescription\tlatitude\tlongitude" > ../data-src/pictures.tsv
exiftool ./ -R -E -T -n -directory -filename -datetimeoriginal -title -description -gpslatitude -gpslongitude >> ../data-src/pictures.tsv
