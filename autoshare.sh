#!/usr/bin/with-contenv sh

CONFIG=/config/smb.conf

if [ ! -f $CONFIG -a "$AUTO_SHARE" = "TRUE" ]; then
  echo "guest account = nobody" >> $CONFIG
  for folder in /share/*; do
    share=$(basename $folder)
    echo "[$share]
    path = $folder
    browseable = yes
    guest ok = yes
    read only = yes" >> $CONFIG
  done
fi
