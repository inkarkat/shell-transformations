#!/usr/bin/env bats

load fixture

@test "field DOESNOTEXIST prints error" {
    run -3 --separate-stderr truncateLongTail --has-header DOESNOTEXIST <<'EOF'
WORDS NUMBERS
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
ERROR: Could not locate field named DOESNOTEXIST in
WORDS NUMBERS
EOF
}
