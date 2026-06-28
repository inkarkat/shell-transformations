#!/usr/bin/env bats

load fixture

@test "non-existing field 3 prints error and exits with 3" {
    run -3 --separate-stderr truncateLongTail 3 <<'EOF'
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
    assert_output ''
    output="$stderr" assert_output - <<'EOF'
ERROR: No field number 3 in
ten 10
EOF
}
