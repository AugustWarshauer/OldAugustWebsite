#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
publish_dir="$(mktemp -d)"
trap 'rm -rf "$publish_dir"' EXIT

bash "$repo_root/scripts/build-pages.sh" "$publish_dir"

required_files=(
  "index.html"
  ".nojekyll"
  "src/index.js"
  "src/styles_augustcoin.css"
  "src/AugustCoin_abi.json"
  "src/AugustFaucet_abi.json"
  "src/AugustsProfiles_abi.json"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$publish_dir/$file" ]]; then
    echo "Missing required published file: $file" >&2
    exit 1
  fi
done

published_html="$(
  find "$publish_dir" -type f -name '*.html' -print |
    sed "s#^$publish_dir/##" |
    sort
)"

if [[ "$published_html" != "index.html" ]]; then
  echo "Only AugustCoin's index.html may be published; found: $published_html" >&2
  exit 1
fi

if ! cmp -s "$repo_root/AugustCoin.html" "$publish_dir/index.html"; then
  echo "Published index.html must match AugustCoin.html" >&2
  exit 1
fi

echo "Pages artifact contains only the AugustCoin page and its required assets."
