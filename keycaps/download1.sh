#!/bin/sh

ICON_NAME=$1
ICON_URL=$2

  echo "  ~~> $ICON_NAME"
  DOWNLOAD="${URL/_____/$ICON_NAME}"
  curl -o icons/${item}.zip $DOWNLOAD
  unzip icons/${item}.zip
  mv 2x/*.png icons/${item}.png
  rm -rf 1x
  rm -rf 2x
  rm icons/${item}.zip
