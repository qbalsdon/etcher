#!/bin/sh

START_URL="https://github.com/google/material-design-icons/tree/master/png"
DOWNLOAD_URL="https://raw.githubusercontent.com/google/material-design-icons/master/png"
SAVE_FOLDER="icons"
rm -rf $SAVE_FOLDER
mkdir $SAVE_FOLDER

function getFolders {
   FOLDER_NAME=$1
   LIST=$(curl -s ${FOLDER_NAME} | grep "/google/material-design-icons/tree/master/png/" | cut -c 129- | cut -f1 -d"\"")
   
   for FOLDER in ${LIST};
   do
      LIST_2=$(curl -s ${FOLDER_NAME}/${FOLDER} | grep "href=\"/google/material-design-icons/tree/master/png/${FOLDER}" | cut -c 129- | cut -f1 -d"\"")
      for SUBFOLDER in ${LIST_2};
      do
          if grep -Fxq "$SUBFOLDER" iconlist
          then
              IMAGE_DIR="$START_URL/$FOLDER/$SUBFOLDER/materialicons/48dp/2x"
              IMAGE_NAME=$(curl -s $IMAGE_DIR | grep ".*>.*\.png<.*" | sed 's/<span class="css-truncate css-truncate-target d-block width-fit"><a class="js-navigation-open Link--primary" title="//g' | cut -f1 -d"\"" | sed 's/ //g')
              IMAGE_DIR="$DOWNLOAD_URL/$FOLDER/$SUBFOLDER/materialicons/48dp/2x/${IMAGE_NAME}"
              SAVE_NAME=${IMAGE_NAME#baseline_}
              SAVE_NAME="${SAVE_NAME%_black_48dp.png}"
              echo "  DOWNLOADING [[$SAVE_FOLDER/${SAVE_NAME}]]"
              curl -s -o $SAVE_FOLDER/${SAVE_NAME}.png $IMAGE_DIR
          #else 
              #echo "     !!~~> Skipping [$SUBFOLDER]"
          fi
      done;
   done;
}

getFolders $START_URL
