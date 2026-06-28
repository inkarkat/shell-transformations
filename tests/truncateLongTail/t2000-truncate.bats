#!/usr/bin/env bats

load fixture

@test "truncation of monotonically decreasing numbers from 10 truncates at 5" {
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

@test "truncation of monotonically decreasing numbers and text from 10 truncates at 5" {
    run -0 truncateLongTail 1 <<'EOF'
10 ten
9 nine
8 eight
7 seven
6 six
5 five
4 four
3 three
2 two
1 one
EOF
    assert_output - <<'EOF'
10 ten
9 nine
8 eight
7 seven
6 six
5 five
EOF
}

@test "truncation of monotonically decreasing numbers from 20 truncates at 6" {
    run -0 truncateLongTail 1 <<'EOF'
20
19
18
17
16
15
14
13
12
11
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
20
19
18
17
16
15
14
13
12
11
10
9
8
7
6
EOF
}

@test "truncation of stepwise decreasing numbers from 10 truncates after 7" {
    run -0 truncateLongTail 1 <<'EOF'
10
10
10
7
7
7
4
4
4
1
1
1
EOF
    assert_output - <<'EOF'
10
10
10
7
7
7
EOF
}
