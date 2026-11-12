#!/usr/bin/env bash
set -u

PORT="${OPENCODE_WEB_PORT:-4096}"
LOG="${OPENCODE_WEB_LOG:-$HOME/.opencode/web.log}"
LOCK_DIR="${XDG_RUNTIME_DIR:-/tmp}"
LOCK="$LOCK_DIR/opencode-web-$PORT.lock"

port_open() {
  ss -ltn 2>/dev/null | awk 'NR>1 {print $4}' | grep -qE "[:.]${PORT}$"
}

port_open && exit 0

mkdir -p "$(dirname "$LOG")" "$LOCK_DIR"
exec 9>"$LOCK"
flock -n 9 || exit 0
port_open && exit 0

BIN="$(command -v opencode 2>/dev/null || true)"
[ -z "$BIN" ] && [ -x "$HOME/.opencode/bin/opencode" ] && BIN="$HOME/.opencode/bin/opencode"
[ -z "$BIN" ] && exit 0

nohup "$BIN" web --port "$PORT" --hostname 0.0.0.0 >>"$LOG" 2>&1 &
disown 2>/dev/null || true

for _ in $(seq 1 50); do
  port_open && exit 0
  sleep 0.2
done
exit 0
