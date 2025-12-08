#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 removeIdenticalField --does-not-exist
    assert_line -n 0 "ERROR: Unknown option \"--does-not-exist\"!"
    assert_line -n -1 -e "^Usage:"
}

@test "regular expression field separator prints an error message" {
    run -2 removeIdenticalField -F ' +' 1 <<'EOF'
foo bar
EOF
    assert_output 'ERROR: The field separator has to be a literal string; it cannot be a regular expression.'
}
