#!/usr/bin/env bats

@test "no input exits with 99" {
    run removeIdenticalField -F $'\t' 1 <<'EOF'
EOF

    [ $status -eq 99 ]
    [ "$output" = "" ]
}
