#!/usr/bin/with-contenv sh

smbd --foreground \
     --log-stdout \
     --no-process-group \
     --configfile "$CONFIG_DIR/smb.conf"
