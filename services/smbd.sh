#!/usr/bin/with-contenv sh

smbd --foreground \
     --log-stdout \
     --no-process-group \
     --configfile $SMB_CONFIG
