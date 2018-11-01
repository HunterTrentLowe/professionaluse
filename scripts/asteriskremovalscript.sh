#!/bin/bash
set -e
	cd /var/spool/asterisk/monitor
	
	find . -type f -name '*.wav' -mtime +30 -delete -or -name '*.mp3' -mtime +30 -delete -or -type d -empty -delete
