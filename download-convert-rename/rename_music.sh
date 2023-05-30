#!/bin/bash
# URL of the video to download
url="https://www.bilibili.com/video/BV1sw411971F/?spm_id_from=333.999.0.0"

# Output directory
outdir="~/cc"

# download video use yt-dlp tools :
#   sudo apt-get update
#   sudo apt-get install python3-pip
#   sudo pip3 install yt-dlp
yt-dlp  $url -o "${outdir}/temp_audio"
echo "download video success"
# convert   mutiple video of folder to mp3  use fmedia tools ,download from https://fmedia.firmdev.com/
./fmedia "${outdir}/temp_audio" -o "${outdir}/$date".mp3
echo "convert to mp3 success"

# Go to the directory
cd "${outdir}"

for file in *.mp3
do
  # Extract the song name and artist from the file name
  song=$(echo "$file" | awk -F ' ' '{print $(NF-1)}')
  artist=$(echo "$file" | awk -F ' ' '{print $NF}' | sed 's/.mp3//')

  # Create the new name by joining the song and artist with a dash
  newname="${song}-${artist}.mp3"

  # Rename the file
  mv "$file" "$newname"
done
echo "rename success"

rm  -r "${outdir}/temp_audio"
echo "remove temp_audio.wav success"
