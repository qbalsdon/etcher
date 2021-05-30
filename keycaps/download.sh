#!/bin/sh

ICON_LIST=$1
ICON_URL=$2

URL=$(cat $ICON_URL)

rm -rf icons
mkdir icons

while read item; do
  echo "  ~~> $item"
  DOWNLOAD="${URL/_____/$item}"
  CURL_CMD="curl -s -o icons/${item}.zip $DOWNLOAD"
  CURL_OUTPUT=`${CURL_CMD} 2> /dev/null` || CURL_RETURN_CODE=$?
  echo "   ~~> CODE: $CURL_RETURN_CODE"
  if [[ $CURL_RETURN_CODE -ne 0 ]]
  then
    #unzip icons/${item}.zip
    #mv 2x/*.png icons/${item}.png
    #rm -rf 1x
    #rm -rf 2x
    #rm icons/${item}.zip
    echo " ~~> it failed: $CURL_RETURN_CODE: $DOWNLOAD"
  else
    #echo " ~~> it failed: $?: $DOWNLOAD"
    echo ""
  fi
done < $ICON_LIST
