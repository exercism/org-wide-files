#!/usr/bin/env python3
"""Apply a target repo's own configuration to the files synced into it.

The sync workflows check this repo out as main/ and the target repo as
track-repo/, then run this script.
"""
import os
import tomllib
from pathlib import Path

MAIN = Path("main")
TARGET = Path("track-repo")
TRACK = os.environ.get("TRACK", "this repo")

with (MAIN / "config.toml").open("rb") as f:
    config = tomllib.load(f)

track_config_file = TARGET / ".github" / "org-wide-files-config.toml"
if track_config_file.is_file():
    with track_config_file.open("rb") as f:
        track_config = tomllib.load(f)

    configlet = track_config.get("configlet", {})
    for key in config["configlet_configurable_keys"]:
        if key not in configlet:
            continue
        if configlet["fmt"]:
            print("Track wants to run configlet fmt; appending to configlet workflow")
            with (TARGET / ".github" / "workflows" / "configlet.yml").open("a") as out:
                out.write("    with:\n      fmt: true\n")
else:
    print(f"{TRACK} does not have an org-wide-files-config.toml")

for name in config["appendable_files"]:
    append_file = TARGET / ".appends" / name
    if not append_file.is_file():
        print(f"{TRACK} does not have an append for {name}")
        continue

    synced = (TARGET / name).read_text().rstrip("\n")
    newlines = config["files"].get(name, {}).get("trailing_newlines", 1)
    (TARGET / name).write_text(synced + "\n" * newlines + append_file.read_text())
    print(f"Appended {name}")
