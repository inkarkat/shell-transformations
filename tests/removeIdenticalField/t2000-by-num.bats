#!/usr/bin/env bats

load fixture

@test "second field is omitted because it is identical" {
    run -0 removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second	foo	blubb
third	foo	end
EOF
    assert_output - <<'EOF'
first	blah
second	blubb
third	end
EOF
}

@test "second field is not omitted because the second line is different" {
    run -0 removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second	bar	blubb
third	foo	end
EOF
    assert_output - <<'EOF'
first	foo	blah
second	bar	blubb
third	foo	end
EOF
}

@test "first field is omitted because it is identical" {
    run -0 removeIdenticalField -F $'\t' 1 <<'EOF'
foo	first	blah
foo	second	blubb
foo	third	end
EOF
    assert_output - <<'EOF'
first	blah
second	blubb
third	end
EOF
}

@test "last field is omitted because it is identical" {
    run -0 removeIdenticalField -F $'\t' 3 <<'EOF'
first	blah	foo
second	blubb	foo
third	end	foo
EOF
    assert_output - <<'EOF'
first	blah
second	blubb
third	end
EOF
}
