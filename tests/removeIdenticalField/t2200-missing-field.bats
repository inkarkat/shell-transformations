#!/usr/bin/env bats

load fixture

@test "second field is not omitted because the second line does not have it" {
    run -0 removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second
third	foo	end
EOF
    assert_output - <<'EOF'
first	foo	blah
second
third	foo	end
EOF
}

@test "second field is not omitted because it is empty in the second line" {
    run -0 removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second		blubb
third	foo	end
EOF
    assert_output - <<'EOF'
first	foo	blah
second		blubb
third	foo	end
EOF
}
