#!/bin/sh
set -e

: "${repo_url:?Need repo_url (HTTPS URL)}"
: "${branch:=main}"
: "${github_token:?Need github_token}"

SRC_DIR=dist
DST_DIR=build

auth_repo_url=$(echo "$repo_url" | sed "s|https://|https://x-access-token:${github_token}@|")
echo "$auth_repo_url"

if [ ! -d /app ]; then
  mkdir /app
  git clone --branch "$branch" "$auth_repo_url" /app
fi

cd /app

git fetch origin "$branch"
git reset --hard "origin/$branch"

if ! bun install; then
  echo "⚠️ bun install failed – cleaning cache & retrying"
  rm -rf node_modules .bun bun.lockb
  bun cache clean
  bun install
fi
bun run build

if [ ! -d "$SRC_DIR" ]; then
  echo "❌ Source directory '$SRC_DIR' not found!" >&2
  exit 1
fi
if [ -d "$DST_DIR" ]; then
  rm -rf "$DST_DIR"
fi

mkdir -p "$DST_DIR"
cp -a "$SRC_DIR"/. "$DST_DIR"/
echo "✅ Copied '$SRC_DIR' → '$DST_DIR'"

nginx -g 'daemon off;'
