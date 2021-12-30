#!/bin/bash

if [[ $# -eq 0 ]]; then
	( >&2 echo "Error: Missing argument \"directory\" in \"$0\"." )
	exit 1
fi

DIR="$1"
RES=$(fd . --type d "$DIR")
echo "$RES"$'\n'$DIR
exit 0
