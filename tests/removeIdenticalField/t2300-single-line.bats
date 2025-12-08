#!/usr/bin/env bats

load fixture

@test "second field of single line is omitted by default" {
    run -0 removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
EOF
    assert_output 'first	blah'
}

@test "second field of single line is not omitted with --keep-single" {
    run -0 removeIdenticalField --keep-single -F $'\t' 2 <<'EOF'
first	foo	blah
EOF
    assert_output 'first	foo	blah'
}

@test "second field of single line after header is omitted by default" {
    run -0 removeIdenticalField -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
EOF
    assert_output - <<'EOF'
COUNT	COMMENT
first	blah
EOF
}

@test "second field of single line after header is not omitted with --keep-single" {
    run -0 removeIdenticalField --keep-single -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
EOF
    assert_output - <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
EOF
}
