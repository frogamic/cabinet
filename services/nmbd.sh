#!/usr/bin/with-contenv sh

nmbd --foreground \
     --log-stdout \
     --no-process-group \
     --configfile "$CONFIG_DIR/smb.conf"
