#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 removeIdenticalField --does-not-exist
    assert_line -n 0 "ERROR: Unknown option \"--does-not-exist\"!"
    assert_line -n -1 -e "^Usage:"
}

@test "regular expression field separator prints note" {
    run -0 --separate-stderr removeIdenticalField -F ' +' 1 <<'EOF'
foo bar
EOF
    output="$stderr" assert_output 'Note: Using space as default output field separator; change via -s|--output-separator OS or pass a non-regular expression -F|--field-separator FS.'
}
