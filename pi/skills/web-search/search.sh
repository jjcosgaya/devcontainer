#!/usr/bin/env bash
# Web search via DuckDuckGo (no API key). Outputs title | url | snippet.
# Auto-creates an isolated venv on first run so it works on externally-managed Pythons.
set -euo pipefail
query="${1:?usage: search.sh \"query\" [num_results]}"
num="${2:-5}"

cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
venv="$cache_home/pi/venvs/web-search"

# Keep generated dependencies outside the stowed skill directory.
if [ ! -x "$venv/bin/python" ]; then
  mkdir -p "$(dirname "$venv")"
  python3 -m venv "$venv" >/dev/null
  "$venv/bin/python" -m pip install -q --disable-pip-version-check ddgs
fi

"$venv/bin/python" - "$query" "$num" <<'PY'
import sys
from ddgs import DDGS

query, num = sys.argv[1], int(sys.argv[2])
with DDGS() as ddgs:
    for r in ddgs.text(query, max_results=num):
        print(f"Title: {r.get('title','')}")
        print(f"URL: {r.get('href','')}")
        body = r.get('body','')
        if len(body) > 300:
            body = body[:300].rstrip() + "..."
        print(f"Snippet: {body}")
        print()
PY
