#!/usr/bin/with-contenv sh

if [ ! -f "$SMB_CONFIG" ]; then
  echo " ######################################"
  echo "#########                      #########"
  echo "########  NO SAMBA CONFIG FILE  ########"
  echo "#########                      #########"
  echo " ######################################"
  exit 1
fi
