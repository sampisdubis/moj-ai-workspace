#!/usr/bin/env bash
set -u
set -o pipefail

PORT="${OPENCODE_WEB_PORT:-4096}"
BIND="${OPENCODE_WEB_HOSTNAME:-0.0.0.0}"
LOG="${OPENCODE_WEB_LOG:-$HOME/.opencode/web.log}"
LOG_MAX_BYTES="${OPENCODE_WEB_LOG_MAX_BYTES:-5242880}"
LOCK_DIR="${XDG_RUNTIME_DIR:-/tmp}"
LOCK="$LOCK_DIR/opencode-web-$PORT.lock"
REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

INSTALL_ONLY=0
for arg in "$@"; do
  case "$arg" in
    --install-only) INSTALL_ONLY=1 ;;
    -h|--help)
      printf 'Usage: %s [--install-only]\n' "$(basename -- "$0")"
      exit 0
      ;;
  esac
done

log() { printf '[%s] %s\n' "$(date -u +%FT%TZ)" "$*" >&2; }

port_open() {
  if command -v ss >/dev/null 2>&1; then
    ss -ltn 2>/dev/null | awk 'NR>1 {print $4}' | grep -qE "[:.]${PORT}$"
  else
    (exec 3<>"/dev/tcp/127.0.0.1/$PORT") 2>/dev/null
  fi
}

resolve_bin() {
  if [ -n "${OPENCODE_BIN:-}" ] && [ -x "${OPENCODE_BIN}" ]; then
    printf '%s' "$OPENCODE_BIN"; return 0
  fi
  local found
  found="$(command -v opencode 2>/dev/null || true)"
  if [ -n "$found" ]; then
    printf '%s' "$found"; return 0
  fi
  if [ -x "$HOME/.opencode/bin/opencode" ]; then
    printf '%s' "$HOME/.opencode/bin/opencode"; return 0
  fi
  return 1
}

install_opencode() {
  if resolve_bin >/dev/null 2>&1; then
    return 0
  fi
  log "opencode nije instaliran; instaliram u $HOME/.opencode/bin"
  curl -fsSL https://opencode.ai/install | bash
  export PATH="$HOME/.opencode/bin:$PATH"
  resolve_bin >/dev/null 2>&1
}

rotate_log() {
  mkdir -p "$(dirname -- "$LOG")"
  [ -f "$LOG" ] || return 0
  local size
  size="$(wc -c <"$LOG" 2>/dev/null || printf '0')"
  if [ "${size:-0}" -gt "$LOG_MAX_BYTES" ]; then
    mv -f "$LOG" "$LOG.1"
  fi
}

if [ "$INSTALL_ONLY" -eq 0 ] && port_open; then
  exit 0
fi

if ! install_opencode; then
  log "instalacija opencode-a nije uspela"
  exit 1
fi

[ "$INSTALL_ONLY" -eq 1 ] && exit 0

if ! BIN="$(resolve_bin)"; then
  log "opencode binarni fajl nije pronadjen"
  exit 1
fi

mkdir -p "$LOCK_DIR"
exec 9>"$LOCK"
flock -n 9 || exit 0
port_open && exit 0

rotate_log
cd -- "$REPO_DIR" || exit 1

setsid nohup "$BIN" web --port "$PORT" --hostname "$BIND" \
  >>"$LOG" 2>&1 </dev/null &
PID=$!
disown "$PID" 2>/dev/null || true

for ((i = 0; i < 50; i++)); do
  if port_open; then
    log "opencode web radi na $BIND:$PORT (pid $PID), log: $LOG"
    exit 0
  fi
  if ! kill -0 "$PID" 2>/dev/null; then
    log "opencode web je izasao odmah; pogledaj $LOG"
    exit 1
  fi
  sleep 0.2
done

log "opencode web nije poceo da slusa na portu $PORT za 10s; pogledaj $LOG"
exit 1
