#!/bin/sh
set -e

: "${repo_url:?Need repo_url (HTTPS URL)}"
: "${branch:=main}"
: "${github_token:?Need github_token}"

cat > ~/.netrc <<EOF
machine github.com
login $github_token
EOF
chmod 600 ~/.netrc

if [ ! -d .git ]; then
  git clone "$repo_url" .
fi

git fetch origin "$branch"
git reset --hard "origin/$branch"

bun install
bun update
bun build

rm -rf /usr/share/nginx/html/*
cp -r build/* /usr/share/nginx/html/

ginx -g 'daemon off;'
