#!/usr/bin/with-contenv sh

# Automount shares
if [ "$AUTO_SHARE" = "TRUE" ]; then

  echo "Autosharing folders (read only)"

  echo "[global]
  guest account = nobody" >> "$CONFIG_DIR/smb.conf"

  for folder in /share/*/; do
    share=$(basename $folder)

    echo " - $folder -> $share"

    echo "[$share]
    path = $folder
    browseable = yes
    guest ok = yes
    read only = yes" >> "$CONFIG_DIR/smb.conf"
  done
fi

# sanity check
if [ ! -f "$CONFIG_DIR/smb.conf" ]; then
  echo "*****  smb.conf missing from $CONFIG_DIR  *****"
  exit 1
fi
