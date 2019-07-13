#!/usr/bin/with-contenv sh

nmbd --foreground \
     --log-stdout \
     --no-process-group \
     --configfile $SMB_CONFIG
