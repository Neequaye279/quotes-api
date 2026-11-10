#!/bin/bash


BASE=${1:-http://localhost:8092}
FAILED=0

check_route(){
	local path=$1
	local code=$(curl -s -o /dev/null -m 5 -w "%{http_code}" "$BASE$path")

	if [ $code == "200" ]; then
		echo "PASS $path ($code)"
	else
		echo "FAIL $path ($code)"
		FAILED=1
	fi
}

check_route /
check_route /quote
check_route /health

exit $FAILED

