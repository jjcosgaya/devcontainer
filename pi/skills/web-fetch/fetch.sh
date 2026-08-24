#!/usr/bin/env bash
# Fetch a URL as clean markdown.
# Tries local trafilatura first; falls back to Jina Reader (remote, renders JS)
# if local extraction is empty/too short or trafilatura is not installed.
# Auto-creates an isolated venv on first run so it works on externally-managed Pythons.
set -euo pipefail
url="${1:?usage: fetch.sh \"https://url\"}"
min_chars=200  # below this, assume local extraction failed (JS-only page)

cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
venv="$cache_home/pi/venvs/web-fetch"

# Keep generated dependencies outside the stowed skill directory.
if [ ! -x "$venv/bin/python" ]; then
  mkdir -p "$(dirname "$venv")"
  python3 -m venv "$venv" >/dev/null
  "$venv/bin/python" -m pip install -q --disable-pip-version-check trafilatura
fi

# Try local extraction with trafilatura
local_md=$("$venv/bin/python" - "$url" <<'PY'
import sys, trafilatura
url = sys.argv[1]
downloaded = trafilatura.fetch_url(url)
text = trafilatura.extract(downloaded, output_format="markdown") or ""
sys.stdout.write(text)
PY
) || local_md=""

# Fall back to Jina Reader if local extraction is empty/too short
if [ "${#local_md}" -lt "$min_chars" ]; then
  curl -sL --max-time 30 "https://r.jina.ai/${url}"
else
  printf '%s' "$local_md"
fi
