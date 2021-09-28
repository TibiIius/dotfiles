#!/bin/bash


for file_path in "$@"
do
  file_full=$(basename -- "$file_path")
  file_name=${file_full%%.*}
  file_extension=${file_full#*.}
  
  if [[ $file_extension = "mkv" ]]; then
#    ffmpeg -i "$file_full" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "$file_name.mov"
    ffmpeg -i "$file_full" -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -c:a pcm_s16le -f mov "./mov/$file_name.mov"
  fi

done
