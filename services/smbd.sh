#!/usr/bin/execlineb -P

smbd --foreground \
     --log-stdout \
     --no-process-group \
     --configfile /config/smb.conf
