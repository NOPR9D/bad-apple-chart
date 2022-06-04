#!/usr/bin/env bash
[ "$1" = "-h" -o "$1" = "--help" ] && echo "
  This script is for VideoToFrames.

  He extract all frames from a video file.

  You can specify the file with file="", if no value the don't start.
  You can specify the frames rate with fps="", if no value the scriptwill start will a default value of 30 fps.

" && exit

DEFAULT_FPS=30

for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   
    case "$KEY" in
            file)              file=${VALUE} ;;
            fps)    fps=${VALUE} ;;     
            *)   
    esac    
done

[ -z "$file" ] && echo "You can specity -h for help" &&  echo "You don't specify a file so we exit" && exit

fileName=(${file//./ })

mkdir ./${fileName[0]}
ffmpeg -skip_frame nokey -i ./assets/$file -vsync 0 -r ${fps:-${DEFAULT_FPS}} -f image2 ./${fileName}/thumbnails-%02d.jpeg