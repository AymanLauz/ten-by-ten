#!/usr/bin/env bash
# Wraps index.html (the game, written without <html>/<head>/<body>) into a full page
# at docs/index.html, which GitHub Pages serves.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p docs

split='<div id="app">'
head_part=$(awk -v s="$split" 'index($0, s) { exit } { print }' index.html)
body_part=$(awk -v s="$split" 'index($0, s) { found = 1 } found { print }' index.html)

cat > docs/index.html <<EOF
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="theme-color" content="#1c1c1c">
<style>
html { box-sizing: border-box; padding-top: env(safe-area-inset-top, 0px); padding-bottom: env(safe-area-inset-bottom, 0px); }
body { margin: 0; font: 14px system-ui, -apple-system, sans-serif; }
</style>
$head_part
</head>
<body>
$body_part
</body>
</html>
EOF
echo "Wrote docs/index.html"
