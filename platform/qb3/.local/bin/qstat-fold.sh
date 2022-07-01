#!/usr/bin/env bash

tbl=$(mktemp)
plines=$1
# qstat | awk -v OFS='	' 'NR!=2' > "$tbl"
qstat-fullname.sh > "$tbl"
nlines=$(cat $tbl | wc -l)
awk -v nlines="$nlines" -v plines="$plines" \
    'NR<(plines / 2){print} \
     NR==(plines / 2){print "[..." nlines - plines " more lines...]"} \
     NR>(nlines - plines / 2) && (plines / 2 < nlines) {print}' \
    "$tbl"
expr $nlines - 2
