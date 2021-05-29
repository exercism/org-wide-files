# org-wide-files

## How it works

On each push to the `main` branch, all files in `synced-files/` will be copied to all Exercism track repos.
A PR will be opened on each repo, which will (in the future) be automatically merged by a webhook integration.

After pushing, you have 5 minutes to abort the workflow, in case there are any errors in the files that should be synced.

## Triggering a run for specific tracks via repository dispatches

To trigger a rerun of the syncer for a list of tracks, [create a repository dispatch event](https://docs.github.com/en/rest/reference/repos#create-a-repository-dispatch-event) with the following payload:

```json
{
  "event_type": "track_changes",
  "client_payload": {
    "tracks": ["exercism/julia"]
  }
}
```

**Note that the track names must be given in the full `org/repo` format.**

## Triggering a run for specific tracks via workflow dispatches

To manually trigger a rerun of the syncer for a list of tracks, [create a workflow dispatch event](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow).

The `tracks` input must be given as a JSON-formatted list of tracks, e.g. `["exercism/julia"]`.

**Note that the track names must be given in the full `org/repo` format.**

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
- Add CI check that each file in `synced_files/` is part of `synced_files/.github/CODEOWNERS`.
