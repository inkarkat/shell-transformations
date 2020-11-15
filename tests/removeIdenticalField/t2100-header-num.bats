#!/usr/bin/env bats

@test "second field after header is omitted because it is identical" {
    run removeIdenticalField --has-header -F $'\t' 2 <<'EOF'
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

@test "second field after header is not omitted because the second line is different" {
    run removeIdenticalField --has-header -F $'\t' 2 <<'EOF'
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

