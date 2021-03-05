# org-wide-files

## Potential use cases

Sync files that must be present and unchanged in all tracks, e.g.

- `CODE_OF_CONDUCT.md`
- Must-have workflows, e.g.
  - configlet
  - markdown linting
  - label.yml syncing (ref. https://github.com/exercism/docs/issues/27)

## Potential future extensions

- Allow edits from maintainers for certain files or apply track-specific automated transformations instead of merely copying all files.
- Add support to rerun workflow for specific tracks only via `workflow_dispatch`.
