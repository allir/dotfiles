# Plan: Reorganize docs/plans before committing

## Context

The `docs/plans/` directory had never been committed. Before adding it to git, two problems needed fixing:

1. **Naming collisions** — topic-based names like `high-severity-fixes.md` would conflict if the same topic recurs.
2. **No single status index** — completion tracking was scattered across individual files (each had its own `**Status:**` line and emoji markers).

## Changes

### 1. Date-prefix all plan filenames

Used `YYYY-MM-DD-topic.md` format. Dates sort chronologically and prevent collisions. Related plans share a name prefix (e.g. `shellcheck-audit-{high,medium,low}`).

| Old name | New name |
|----------|----------|
| `stow-migration.md` | `2026-02-13-stow-migration.md` |
| `high-severity-fixes.md` | `2026-02-13-shellcheck-audit-high.md` |
| `medium-severity-fixes.md` | `2026-02-13-shellcheck-audit-medium.md` |
| `low-severity-fixes.md` | `2026-02-13-shellcheck-audit-low.md` |
| `readme-update.md` | `2026-02-14-readme-update.md` |

### 2. Create `docs/plans/README.md` as the single status index

Auto-renders on GitHub when browsing `docs/plans/`. Contains a table with date, plan link, status, and commit hashes.

### 3. Strip status metadata from individual plan files

Removed from each file:
- `**Status:** COMPLETED` and `**Commits:**` lines
- Emoji legend (`> ✅ Completed · ❌ Failed · 🚫 Rejected`)
- `✅` / `🚫` suffixes on item headings
- For the one rejected item (low-severity #10), converted `🚫` to a `**Decision:**` label

### 4. Update `MEMORY.md` references

Updated file paths to use the new date-prefixed names.

### 5. Add plans convention to `CLAUDE.md`

Added a "Plans" section after "Pitfalls" documenting how to create and track plans going forward.

## Files modified

| File | Action |
|------|--------|
| `docs/plans/README.md` | Create — status index |
| `docs/plans/2026-02-13-stow-migration.md` | Rename + strip status block |
| `docs/plans/2026-02-13-shellcheck-audit-high.md` | Rename + strip status/emoji |
| `docs/plans/2026-02-13-shellcheck-audit-medium.md` | Rename + strip status/emoji |
| `docs/plans/2026-02-13-shellcheck-audit-low.md` | Rename + strip status/emoji |
| `docs/plans/2026-02-14-readme-update.md` | Rename + strip status block |
| `CLAUDE.md` | Add "Plans" section after "Pitfalls" |
| `MEMORY.md` | Update file path references |
