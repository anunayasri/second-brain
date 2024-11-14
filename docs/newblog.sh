#!/bin/bash

# Check if a filename was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi 

FILENAME="$1"

if [ ! -e "$FILENAME" ]; then
    touch "$FILENAME"
    echo "File '$FILENAME' created."
else
    echo "File '$FILENAME' already exists."
    return 1
fi

NEW_BLOG_TEMPLATE=$(cat <<EOF
---
title: <Title>
date: YYYY-MM-DD
draft: true
categories:
  - <1>
  - <2>
---

> Blog preview here

<!-- more -->

# Start writing here
EOF
)

echo "$NEW_BLOG_TEMPLATE" >> "$FILENAME"
