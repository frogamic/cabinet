#!/usr/bin/with-contenv sh

if [ ! -f "$SMB_CONFIG" -a "$AUTO_SHARE" = "TRUE" ]; then
  echo "guest account = nobody" >> $SMB_CONFIG
  for folder in /share/*; do
    share=$(basename $folder)
    echo "[$share]
    path = $folder
    browseable = yes
    guest ok = yes
    read only = yes" >> $SMB_CONFIG
  done
fi
