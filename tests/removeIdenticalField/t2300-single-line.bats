#!/usr/bin/env bats

@test "second field of single line is omitted by default" {
    run removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	blah" ]
}

@test "second field of single line is not omitted with --keep-single" {
    run removeIdenticalField --keep-single -F $'\t' 2 <<'EOF'
first	foo	blah
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	foo	blah" ]
}

@test "second field of single line after header is omitted by default" {
    run removeIdenticalField -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
EOF

    [ $status -eq 0 ]
    [ "$output" = "COUNT	COMMENT
first	blah" ]
}

@test "second field of single line after header is not omitted with --keep-single" {
    run removeIdenticalField --keep-single -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
EOF

    [ $status -eq 0 ]
    [ "$output" = "COUNT	VAL	COMMENT
first	foo	blah" ]
}
