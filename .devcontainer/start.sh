#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
if [ -s /usr/local/share/nvm/nvm.sh ]; then
  source /usr/local/share/nvm/nvm.sh
  nvm use 24
fi
if [ ! -f packages/core/dist/scramjet.wasm ]; then
  echo 'Run bash .devcontainer/setup.sh first.'
  exit 1
fi
if [ -f /tmp/scramjet.pid ] && kill -0 "$(cat /tmp/scramjet.pid)" 2>/dev/null; then
  echo 'Scramjet is already running.'
  exit 0
fi
nohup pnpm dev >/tmp/scramjet.log 2>&1 &
echo $! >/tmp/scramjet.pid
echo 'Scramjet starting on port 4141. Log: /tmp/scramjet.log'
