#!/usr/bin/env bats

load fixture

@test "truncation of headered text and monotonically decreasing numbers from 10 in numbered field truncates at 5" {
    # Note: We need the --has-header flag so that the first line is skipped.
    run -0 truncateLongTail --has-header 2 <<'EOF'
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
    assert_output - <<'EOF'
WORDS NUMBERS
ten 10
nine 9
eight 8
seven 7
six  6
five 5
EOF
}
