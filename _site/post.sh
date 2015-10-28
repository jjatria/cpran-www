#!/bin/bash

TEMP=`getopt -o t:c:T: --long tags:,categories:,tagline: -n 'post.sh' -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

TAGS=
CATEGORIES=
TAGLINE=
while true; do
  case "$1" in
    -t | --tags ) TAGS="$2"; shift 2;;
    -c | --categories ) CATEGORIES="$2"; shift 2;;
    -T | --tagline ) TAGLINE="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

TITLE=$1
DATE=$(date +%Y-%m-%d)
NAME=$(echo "$TITLE" | perl -e '$_ = lc(<>); s/^\(//; s/\s*[ ,.;:?!()]+\s*/-/g; s/-$//; print')
FILENAME="_posts/$DATE-$NAME.md"

# Write the metadata to create a template
echo -n "---
layout: post
title: \"$TITLE\"
tags: [$TAGS]
" > $FILENAME
if [ "X$CATEGORIES" != "X" ]; then
  echo "categories: [$CATEGORIES]" >> $FILENAME
fi
if [ "X$TAGLINE" != "X" ]; then
  echo "tagline: $TAGLINE" >> $FILENAME
fi
echo -n "---
{% include JB/setup %}

" >> "$FILENAME"

# If the user makes no changes to the template, we assume they have cancelled
# the post, and the template needs to be removed.
cp "$FILENAME" "$FILENAME.bkp"
joe "$FILENAME"
if [ "$?" == 0 ]; then
  echo "Aborted post"
  rm "$FILENAME"
fi
rm "$FILENAME.bkp"
