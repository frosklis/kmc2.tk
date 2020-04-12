#!/bin/bash
# needs cjpeg to be mozjpeg
echo `which cjpeg`
cd "${0%/*}"
depth="${2:-0}"
# $1 = ../content/posts
# for d in $(find ../content/posts -maxdepth 2 -type d)
for f in $(find "$1" -maxdepth $depth -regex ".*\.jpg")
do
  #Do something, the directory is accessible with $d:
  echo "$f"
  cjpeg -quality 75 -progressive -optimize "$f" > salida.jpg
  mv salida.jpg "$f"
done