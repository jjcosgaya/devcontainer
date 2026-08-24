---
name: web-search
description: Search the web using DuckDuckGo (no API key needed). Use when you need to find current information, look up facts, or research topics online.
---

# Web Search

Search the web via DuckDuckGo. No API key required.

## Usage

```bash
./search.sh "your query here" [num_results]
```

Default: 5 results. Each result has title, URL, and a snippet (truncated to 300 chars).

## Examples

```bash
./search.sh "latest python version"
./search.sh "how to parse json in rust" 3
```
