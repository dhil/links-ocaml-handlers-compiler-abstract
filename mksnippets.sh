#!/bin/bash

if [[ -z $1 || -z $2 ]]; then
    echo "$(basename $0) <source> <output directory>"
    exit 1
fi
# Parameters
SOURCE=$1
OUTDIR=$2

if [[ ! -d "$OUTDIR" ]]; then
   echo "error: \"$OUTDIR\" no such directory found." > /dev/stderr
   exit 1
fi

# Markers enclosing code snippets
BEGIN_MARKER="#snippet:"
END_MARKER="#end"

# Keep whitespace when reading
IFS=''

# In the beginning there was emptiness
FILE=

cat "$SOURCE" |
sed -n "/^$BEGIN_MARKER/,/^$END_MARKER *\$/p" |
while read line; do
    if [[ $line = "$BEGIN_MARKER"* ]]; then
	FILE=$(echo "$line" | sed "s/$BEGIN_MARKER//")
	rm -f "$OUTDIR/$FILE" && touch "$OUTDIR/$FILE"
    elif [[ $line = "$END_MARKER" ]]; then
	unset FILE
    elif [[ ! -z FILE ]]; then
	echo -e "$line" >> "$OUTDIR/$FILE"
    fi
done
