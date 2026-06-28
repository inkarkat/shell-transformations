#!/usr/bin/env bats

load fixture

@test "truncation of monotonically decreasing even numbers from 10 truncates at 6 with cleared trigger lnum" {
    TRUNCATELONGTAIL_TRIGGER_LNUM='' run -0 truncateLongTail 1 <<'EOF'
10
8
6
4
2
EOF
    assert_output - <<'EOF'
10
8
6
EOF
}

@test "truncation of monotonically decreasing even numbers from 10 does not truncate due to only 5 lines" {
    run -0 truncateLongTail 1 <<'EOF'
10
8
6
4
2
EOF
    assert_output - <<'EOF'
10
8
6
4
2
EOF
}

@test "truncation of decreasing numbers from 10 where the truncation happens before the trigger line number" {
    run -0 truncateLongTail 1 <<'EOF'
10
7
5
4
3
2
1
EOF
    assert_output - <<'EOF'
10
7
5
EOF
}

@test "truncation of decreasing numbers from 10 where the truncation happens on the trigger line number" {
    run -0 truncateLongTail 1 <<'EOF'
10
9
7
6
5
4
3
2
1
EOF
    assert_output - <<'EOF'
10
9
7
6
5
EOF
}

@test "truncation of decreasing numbers from 10 where the truncation happens after the trigger line number" {
    run -0 truncateLongTail 1 <<'EOF'
10
9
8
7
6
5
4
3
2
1
EOF
    assert_output - <<'EOF'
10
9
8
7
6
5
EOF
}

@test "truncation of decreasing numbers from 10 with inclusion where the truncation happens before the trigger line number" {
    run -0 truncateLongTail --include '^2' 1 <<'EOF'
10
7
5
4
3
2
1
EOF
    assert_output - <<'EOF'
10
7
5
[...]
2
EOF
}

@test "truncation of decreasing numbers from 10 with inclusion where the truncation happens on the trigger line number" {
    run -0 truncateLongTail --include '^2' 1 <<'EOF'
10
9
7
6
5
4
3
2
1
EOF
    assert_output - <<'EOF'
10
9
7
6
5
[...]
2
EOF
}

@test "truncation of decreasing numbers from 10 with inclusion where the truncation happens after the trigger line number" {
    run -0 truncateLongTail --include '^2' 1 <<'EOF'
10
9
8
7
6
5
4
3
2
1
EOF
    assert_output - <<'EOF'
10
9
8
7
6
5
[...]
2
EOF
}

@test "truncation of decreasing numbers from 10 with inclusion where the no truncation happens due to only 5 lines" {
    run -0 truncateLongTail --include '^2' 1 <<'EOF'
10
7
5
2
1
EOF
    assert_output - <<'EOF'
10
7
5
2
1
EOF
}

@test "truncation with custom trigger lnum of 4" {
    TRUNCATELONGTAIL_TRIGGER_LNUM=4 run -0 truncateLongTail 1 <<'EOF'
10
8
6
4
EOF
    assert_output - <<'EOF'
10
8
6
EOF

    TRUNCATELONGTAIL_TRIGGER_LNUM=4 run -0 truncateLongTail 1 <<'EOF'
10
5
1
EOF
    assert_output - <<'EOF'
10
5
1
EOF
}
