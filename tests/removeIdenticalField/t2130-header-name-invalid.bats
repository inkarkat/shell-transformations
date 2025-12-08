#!/usr/bin/env bats

load fixture

@test "field DOESNOTEXIST prints error" {
    run -3 removeIdenticalField -F $'\t' DOESNOTEXIST <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
second	foo	blubb
third	foo	end
EOF
    assert_output - <<'EOF'
ERROR: Could not locate field named DOESNOTEXIST in
COUNT	VAL	COMMENT
EOF
}
