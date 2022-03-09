using TOML

# Parse config files
global_cfg = TOML.parsefile(joinpath("main", "config.toml"))

# Track config
# Check for existence of track config file
track_cfg_file = joinpath("track-repo", ".github", "org-wide-files-config.toml")
if isfile(track_cfg_file)
    track_cfg = TOML.parsefile(track_cfg_file)

    # Configlet
    if haskey(track_cfg, "configlet")
        # Iterate through allowed configlet settings
        for key in global_cfg["configlet_configurable_keys"]
            haskey(track_cfg["configlet"], key) || continue

            if track_cfg["configlet"]["fmt"]
                @info "Track wants to run configlet fmt; appending configlet workflow"

                open(joinpath("track-repo", ".github", "workflows", "configlet.yml"), "a") do io
                    write(io, "    with:\n      fmt: true\n")
                end
            end
        end
    end
else
    @info "$(ENV["TRACK"]) does not have an org-wide-files-config.toml"
end

# Appends
# Iterate through files listed in global config file
for file in global_cfg["appendable_files"]
    append_path = joinpath("track-repo", ".appends", file)

    # Check for existance of append file
    isfile(append_path) || (@info "$(ENV["TRACK"]) does not have an append for $file"; continue)

    # Read content of append file
    append_content = read(append_path, String)

    # Append file
    open(joinpath("track-repo", file), "a") do io
        write(io, append_content)

        @info "Appended $file" append_content
    end
end
