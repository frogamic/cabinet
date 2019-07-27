#!/usr/bin/with-contenv sh
EXPORT_FORMAT="smbpasswd"
USERS_FILE="$CONFIG_DIR/samba-users.$EXPORT_FORMAT"
SMB_CONF="$CONFIG_DIR/smb.conf"

add_group_usage="addgroup name [gid]"
#                          $1   $2
add_group() {
  case "$#" in
    "1")
      addgroup $1
      ;;
    "2")
      addgroup -g $2 $1
      ;;
    *)
      echo "Usage - $add_group_usage"
  esac
}

add_user_usage="adduser password [uid] [gid]"
#                          $1     $2    $3
add_user() {
  if [ $# -eq 1 ]; then
    adduser -D -H $1
  elif [ $# -eq 2 ]; then
    adduser -D -H -u $2 $1
  elif [ $# -eq 3 ]; then
    addgroup -g $3 $1 && \
    adduser -D -H -u $2 -G $1 $1
  else
    echo "Usage - $add_user_usage"
    return 0
  fi
  pdbedit -s $SMB_CONF -a -u $1
  smb_export
}

smb_import() {
  if [ -f $USERS_FILE ]; then
    echo "Importing Users"
    pdbedit -s $SMB_CONF -i $EXPORT_FORMAT:$USERS_FILE
    for user in $(cat $USERS_FILE); do
      name=$(echo $user | cut -d ':' -f1)
      [ "$name" = "]" ] && break;
      nthash=$(echo $user | cut -d ':' -f4)
      echo " - $name"
      pdbedit -s $SMB_CONF -u $name --set-nt-hash $nthash > /dev/null
    done
  else
    echo "No user data to import"
  fi
}

smb_export() {
  pdbedit -s $SMB_CONF -e $EXPORT_FORMAT:$USERS_FILE
}

cabinett() {
  case "$1" in
    "exit")
      exit
      ;;
    "export")
      smb_export
      ;;
    "import")
      smb_import
      ;;
    "adduser")
      add_user $2 $3 $4
      ;;
    "addgroup")
      add_group $2 $3
      ;;
    *)
      echo "Usage:
- exit
- import
- export
- $add_user_usage
- $add_group_usage"
      ;;
  esac
}

if [ $# -eq 0 ]; then
  while true; do
    read -p 'cabinett # ' input
    cabinett $input
  done
else
  cabinett $@
fi
