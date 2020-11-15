#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run removeIdenticalField --does-not-exist
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Unknown option \"--does-not-exist\"!" ]
    [ "${lines[-1]%% *}" = "Usage:" ]
}

@test "regular expression field separator prints an error message" {
    run removeIdenticalField -F ' +' 1 <<'EOF'
foo bar
EOF
    [ $status -eq 2 ]
    [ "$output" = "ERROR: The field separator has to be a literal string; it cannot be a regular expression." ]
}
