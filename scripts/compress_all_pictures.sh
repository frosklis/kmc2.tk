#!/bin/bash
# needs cjpeg to be mozjpeg
echo `which cjpeg`
cd "${0%/*}"

# for d in $(find ../content/posts -maxdepth 2 -type d)
for f in $(find ../content/posts -maxdepth 3 -regex ".*\.jpg")
do
  #Do something, the directory is accessible with $d:
  echo $f
  cjpeg -quality 75 -progressive -optimize $f > salida.jpg
  mv salida.jpg $f
done