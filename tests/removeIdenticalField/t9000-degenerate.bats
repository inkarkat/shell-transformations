#!/usr/bin/env bats

load fixture

@test "single field is omitted because it is identical" {
    run -0 removeIdenticalField 1 <<'EOF'
foo
foo
foo
EOF
    assert_output ''
}


@test "single field is not omitted because the second line is different" {
    run -0 removeIdenticalField 1 <<'EOF'
foo
bar
foo
EOF
    assert_output - <<'EOF'
foo
bar
foo
EOF
}
