# org-wide-files

## How it works

On each push to the `main` branch, all files in `synced-files/` will be copied to all Exercism track repos.
A PR will be opened on each repo, which will (in the future) be automatically merged by a webhook integration.

After pushing, you have 5 minutes to abort the workflow, in case there are any errors in the files that should be synced.

## Potential use cases

Sync files that must be present and unchanged in all tracks, e.g.

- `CODE_OF_CONDUCT.md`
- `LICENSE.md` with up-to-date year
- Must-have workflows, e.g.
  - configlet
  - markdown linting
  - label.yml syncing (ref. https://github.com/exercism/docs/issues/27)

## Potential future extensions

- Allow edits from maintainers for certain files or apply track-specific automated transformations instead of merely copying all files.
- Add support to rerun workflow for specific tracks only via `workflow_dispatch`.
