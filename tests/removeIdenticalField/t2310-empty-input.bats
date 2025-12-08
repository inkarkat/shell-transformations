#!/usr/bin/env bats

load fixture

@test "no input exits with 99" {
    run -99 removeIdenticalField -F $'\t' 1 <<'EOF'
EOF
    assert_output ''
}
