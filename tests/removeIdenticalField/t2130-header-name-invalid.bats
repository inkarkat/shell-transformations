#!/usr/bin/env bats

@test "field DOESNOTEXIST prints error" {
    run removeIdenticalField -F $'\t' DOESNOTEXIST <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
second	foo	blubb
third	foo	end
EOF

    [ $status -eq 3 ]
    [ "$output" = "ERROR: Could not locate field named DOESNOTEXIST in
COUNT	VAL	COMMENT" ]
}
