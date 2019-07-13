#!/usr/bin/execlineb -P

nmbd --foreground \
     --log-stdout \
     --no-process-group \
     --configfile /config/smb.conf
