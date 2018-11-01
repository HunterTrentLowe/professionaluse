#!/bin/bash
set -e

	$(cd /var/spool/asterisk/monitor)

        find . -type f -name '*.mp3' -mtime +60 -delete  

        find . -type f -name '*.wav' -mtime +60 -delete

        find . -type d -empty -delete 
