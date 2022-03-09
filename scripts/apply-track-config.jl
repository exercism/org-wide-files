using TOML

# Parse config files
global_cfg = TOML.parsefile(joinpath("main", "config.toml"))

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
