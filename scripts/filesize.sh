#!/bin/bash
set -e 

	for DIR in {/var,/etc,/home}; do
		echo "=====Showing top 10 directories consuming space in ${DIR} directory====="
		du -h --time ${DIR} |sort -nr | head -n10 && echo "================== END OF TOP SPACE CONSUMED IN ${DIR}==================" && echo "";
       	done

#===DU===#
# -c produce a grand total at end of du
# -h print in human readable
#==SORT==#
# -n compare values to string numerical value
# -r Reverse the results of comparison to show largest files first
