#!/usr/bin/env bats

@test "non-existing field 4 prints error" {
    run removeIdenticalField -F $'\t' 4 <<'EOF'
first	foo	blah
second	foo	blubb
third	foo	end
EOF

    [ $status -eq 3 ]
    [ "$output" = "ERROR: No field number 4 in
first	foo	blah" ]
}
