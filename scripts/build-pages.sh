#!/usr/bin/env bash

set -euo pipefail

if [[ "$#" -ne 1 ]]; then
  echo "Usage: $0 OUTPUT_DIRECTORY" >&2
  exit 64
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
output_dir="$1"

mkdir -p "$output_dir/src"

cp "$repo_root/AugustCoin.html" "$output_dir/index.html"
cp "$repo_root/src/index.js" "$output_dir/src/index.js"
cp "$repo_root/src/styles_augustcoin.css" "$output_dir/src/styles_augustcoin.css"
cp "$repo_root/src/AugustCoin_abi.json" "$output_dir/src/AugustCoin_abi.json"
cp "$repo_root/src/AugustFaucet_abi.json" "$output_dir/src/AugustFaucet_abi.json"
cp "$repo_root/src/AugustsProfiles_abi.json" "$output_dir/src/AugustsProfiles_abi.json"
touch "$output_dir/.nojekyll"
