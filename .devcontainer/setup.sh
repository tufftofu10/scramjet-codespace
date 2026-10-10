#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
mkdir -p "$HOME/.local/bin" "$HOME/.local/lib"
if ! command -v cargo >/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
if [ -s /usr/local/share/nvm/nvm.sh ]; then
  source /usr/local/share/nvm/nvm.sh
  nvm install 24
  nvm use 24
fi
corepack enable
corepack prepare pnpm@10.12.1 --activate
git submodule update --init --recursive
pnpm install --frozen-lockfile
rustup toolchain install nightly --component rust-src --target wasm32-unknown-unknown
if ! wasm-bindgen --version 2>/dev/null | grep -q '0.2.105'; then
  cargo install wasm-bindgen-cli --version 0.2.105 --locked
fi
if ! command -v wasm-opt >/dev/null; then
  version=$(curl -fsSL https://api.github.com/repos/WebAssembly/binaryen/releases/latest | node -e 'let s="";process.stdin.on("data",d=>s+=d);process.stdin.on("end",()=>console.log(JSON.parse(s).tag_name))')
  scratch=$(mktemp -d)
  curl -fL "https://github.com/WebAssembly/binaryen/releases/download/$version/binaryen-$version-x86_64-linux.tar.gz" -o "$scratch/binaryen.tar.gz"
  tar -xzf "$scratch/binaryen.tar.gz" -C "$scratch"
  cp "$scratch/binaryen-$version/bin/"* "$HOME/.local/bin/"
  cp -a "$scratch/binaryen-$version/lib/." "$HOME/.local/lib/"
fi
if ! command -v wasm-snip >/dev/null; then
  cargo install --git https://github.com/r58playz/wasm-snip --locked
fi
pnpm --dir packages/core rewriter:build
pnpm --dir packages/core build
echo 'Scramjet setup complete.'
