#!/usr/bin/env bats

@test "field VAL after header is omitted because it is identical" {
    run removeIdenticalField -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
second	foo	blubb
third	foo	end
EOF

    [ $status -eq 0 ]
    [ "$output" = "COUNT	COMMENT
first	blah
second	blubb
third	end" ]
}

@test "field VAL after header is not omitted because the second line is different" {
    run removeIdenticalField -F $'\t' VAL <<'EOF'
COUNT	VAL	COMMENT
first	foo	blah
second	bar	blubb
third	foo	end
EOF

    [ $status -eq 0 ]
    [ "$output" = "COUNT	VAL	COMMENT
first	foo	blah
second	bar	blubb
third	foo	end" ]
}

