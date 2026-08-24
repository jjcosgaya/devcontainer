---
name: web-fetch
description: Fetch a web page and return its content as clean markdown (no API key, no dependencies). Use when you need to read the full content of a URL.
---

# Web Fetch

Fetch any URL and get its content as clean markdown.
Tries local extraction (trafilatura) first; falls back to Jina Reader
(remote, renders JS) if the page is empty or JS-only.

## Usage

```bash
./fetch.sh "https://example.com/page"
```

Returns the page content as markdown, ready to read or pass to the model.

## Examples

```bash
./fetch.sh "https://en.wikipedia.org/wiki/Python_(programming_language)"
./fetch.sh "https://docs.python.org/3/"
```
