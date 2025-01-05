#!/bin/bash

# Usage: ./devto-new.sh <article-name>
# Set DEV_TO_API_KEY in /hack/.env

NAME=$1
API_KEY=$(cat hack/.env | grep DEV_TO_API_KEY | cut -d '=' -f 2)

# 1. Create a new article
id=$(curl -s -X POST -H "Content-Type: application/json" \
  -H "api-key: ${API_KEY}" \
  -d '{"article":{"title":"'${NAME}'","body_markdown":"Sample Body","published":false}}' \
  https://dev.to/api/articles | jq -r '.id')

echo "[ID] $id"

if [ "$id" = "null" ] || [ "$id" = "" ]; then
  echo "[ERROR] Failed to create new article"
  exit 1
fi

# 2. create new article dir
mkdir -p ./posts/$NAME
mkdir -p ./posts/$NAME/images

# 3. create new article file
echo "---
title: \"${NAME}\"
published: false
description: \"\"
tags: []
---" > ./posts/$NAME/index.md

# 4. add new article to dev-to-git.json.
jq --arg path "./posts/$NAME/index.md" --arg id "$id" '. + [{"relativePathToArticle": $path, "id": $id}]' dev-to-git.json > tmp.json
mv tmp.json dev-to-git.json

