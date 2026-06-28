#!/usr/bin/env bats

load fixture

@test "truncation of text and monotonically decreasing numbers from 10 in field 2 / last field truncates at 5" {
    for field in 2 -1
    do
	{
	    run -0 truncateLongTail "$field" <<'EOF'
ten 10
nine 9
eight 8
seven 7
six  6
five 5
four 4
three 3
two  2
one  1
EOF
	} && {
	    assert_output - <<'EOF'
ten 10
nine 9
eight 8
seven 7
six  6
five 5
EOF
	} || fail "$field"
    done
}
