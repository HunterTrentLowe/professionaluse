#!/bin/bash
set -e #set error prevention, errors stop script
		
	TIME=$(date --rfc-3330=date) #for log file creation with time
        ASTDIR=/var/spool/asterisk/monitor/; #VAR to point to asterisk dir 
	OLDWAV=$(find ${ASTDIR}. -type f -name '*.wav' -mtime +60 -printf '.' | wc -c) #VAR to total # of wav files > 60 days
	OLDMP3=$(find ${ASTDIR}. -type f -name '*.mp3' -mtime +60 -printf '.' | wc -c) #VAR to total # of mp3 files > 60 days
	
	exec &> /var/log/AsteriskRemovalScript_${TIME} #create a log file in /var/log eg AsteriskRemovalScript_11/10/2018

	echo "---DELETE SCRIPT---";
	echo "";

	if [ ${OLDWAV} -eq 0 ]; then #if/else no files exist over 60 days
		echo "There are no .wav files to remove...";
	else
		echo "Removing ${OLDWAV} .wav files older than 60 days..."; #total files to remove
		sleep 1;
		find ${ASTDIR}. -type f -name '*.wav' -mtime +60 -exec rm {} \; 
        	sleep 1;

	        OLDWAVDEL=$(find ${ASTDIR}. -type f -name '*.wav' -mtime +60 -printf '.' |wc -c);

        	if [ "$OLDWAVDEL" -eq 0 ]; then #if/else all .wav files > 60 days are deleted
	        	echo "Removed ${OLDWAV} wav files successfully";
        		echo "";
        	else
	        	echo "${OLDWAVDEL} .wav files older than 60 days weren't deleted... Please re-run script";
        		echo "";
        	fi;
	fi;


        if [ ${OLDMP3} -eq 0 ]; then #Prevent running unecassary commands if no files exist over 60 days
                echo "There are no .mp3 files to remove...";
        else
                echo "Removing ${OLDMP3} .mp3 files older than 60 days..."; #total files to remove
                sleep 1;
                find ${ASTDIR}. -type f -name '*.mp3' -mtime +60 -exec rm {} \; #find mp3's > 60 days and remove
                sleep 1;

                OLDMP3DEL=$(find ${ASTDIR}. -type f -name '*.mp3' -mtime +60 -printf '.' |wc -c);

                if [ "$OLDWAVDEL" -eq 0 ]; then #if/else all mp3's > 60 days are deleted or not
        	        echo "Removed ${OLDMP3}.mp3 files successfully";
                	echo "";
	        else
        	        echo "${OLDMP3DEL} .mp3 files older than 60 days weren't deleted... Please re-run script";
	                echo "";
                fi;
        fi;

	echo "Deleting empty directories...";
	find ${ASTDIR}. -type d -empty -delete; # Delete any empty directories
	exit; #end of script
