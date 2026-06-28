#!/usr/bin/env bats

load fixture

@test "truncation of monotonically decreasing numbers from 10 truncates at 5 but explicitly includes the 2" {
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

@test "truncation of monotonically decreasing numbers from 10 truncates at 5 but explicitly includes important lines" {
    run -0 truncateLongTail --include important 1 <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
4 four
3 important three
2 two
1 important one
EOF
    assert_output - <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
[...]
3 important three
[...]
1 important one
EOF
}

@test "truncation of monotonically decreasing numbers from 10 truncates at 5 but explicitly includes important lines only once for each block of consecutive lines" {
    run -0 truncateLongTail --include important 1 <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
4 four
3 important three
3 even more important three
3 the most important three
2 two
1 important one
1 another important one
EOF
    assert_output - <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
[...]
3 important three
3 even more important three
3 the most important three
[...]
1 important one
1 another important one
EOF
}

@test "truncation of monotonically decreasing numbers from 10 truncates at 5 but explicitly includes important lines with custom separator" {
    TRUNCATELONGTAIL_INCLUDE_SEPARATOR='--- cut ---' run -0 truncateLongTail --include important 1 <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
4 four
3 important three
2 two
1 important one
EOF
    assert_output - <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
--- cut ---
3 important three
--- cut ---
1 important one
EOF
}

@test "truncation of monotonically decreasing numbers from 10 truncates at 5 but explicitly includes important lines without separator" {
    TRUNCATELONGTAIL_INCLUDE_SEPARATOR='' run -0 truncateLongTail --include important 1 <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
4 four
3 important three
2 two
1 important one
EOF
    assert_output - <<'EOF'
10 ten
9 important nine
8 eight
7 seven
6 six
5 five
3 important three
1 important one
EOF
}
