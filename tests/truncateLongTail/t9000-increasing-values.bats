#!/usr/bin/env bats

load fixture

@test "truncation of decreasing and then increasing (after truncation) numbers prints warning" {
    run -0 --separate-stderr truncateLongTail 1 <<'EOF'
10
9
8
7
6
5
4
5
2
9
EOF
    assert_output - <<'EOF'
10
9
8
7
6
5
EOF
    output="$stderr" assert_output - <<'EOF'
Warning: Value 5 in line 8 exceeds threshold 4 again; the values in field 1 are not decreasing.
Warning: Value 9 in line 10 exceeds threshold 4 again; the values in field 1 are not decreasing.
EOF
}
