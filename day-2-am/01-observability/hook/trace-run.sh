#!/usr/bin/env bash
# Stop hook - append a one-line record of this run to runs/trace.jsonl.
# Fires at the end of each assistant turn. Kept cheap and non-fatal on purpose.
cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0
mkdir -p runs
ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
changed="$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')"
commits="$(git rev-list --count HEAD 2>/dev/null || echo 0)"
jq -cn \
  --arg at "$ts" \
  --arg branch "$branch" \
  --argjson changed_files "${changed:-0}" \
  --argjson commits "${commits:-0}" \
  '{at: $at, branch: $branch, changed_files: $changed_files, commits: $commits}' \
  >> runs/trace.jsonl
exit 0
