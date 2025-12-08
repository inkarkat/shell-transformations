#!/usr/bin/env bats

load fixture

@test "non-existing field 4 prints error" {
    run -3 removeIdenticalField -F $'\t' 4 <<'EOF'
first	foo	blah
second	foo	blubb
third	foo	end
EOF
    assert_output - <<'EOF'
ERROR: No field number 4 in
first	foo	blah
EOF
}
