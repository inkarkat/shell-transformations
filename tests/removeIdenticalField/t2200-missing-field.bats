#!/usr/bin/env bats

@test "second field is not omitted because the second line does not have it" {
    run removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second
third	foo	end
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	foo	blah
second
third	foo	end" ]
}

@test "second field is not omitted because it is empty in the second line" {
    run removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second		blubb
third	foo	end
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	foo	blah
second		blubb
third	foo	end" ]
}
