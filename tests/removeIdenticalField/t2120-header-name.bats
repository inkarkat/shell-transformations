#!/usr/bin/env bats

load fixture

@test "field VAL after header is omitted because it is identical" {
    run -0 removeIdenticalField -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
second	foo	blubb
third	foo	end
EOF
    assert_output - <<'EOF'
COUNT	COMMENT
first	blah
second	blubb
third	end
EOF
}

@test "field VAL after header is not omitted because the second line is different" {
    run -0 removeIdenticalField -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
second	bar	blubb
third	foo	end
EOF
    assert_output - <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
second	bar	blubb
third	foo	end
EOF
}

