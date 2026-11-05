#!/bin/bash

URL=${1:-http://localhost:8092/health}
LOG="$HOME/quotes-api/health.log"

for i in 1 2 3;do
	CODE=$(curl -s -o /dev/null -m 5 -w "%{http_code}" "$URL")
	if [ "$CODE" == "200" ]; then
		echo "$(date '+%F %T') UP $URL" | tee -a "$LOG"
		exit 0
	fi
	sleep 2
done

echo "$(date '+%F %T') DOWN $URL (code $CODE)" | tee -a "$LOG"
exit 1
