#!/usr/bin/env bats

@test "second field is omitted because it is identical" {
    run removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second	foo	blubb
third	foo	end
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	blah
second	blubb
third	end" ]
}

@test "second field is not omitted because the second line is different" {
    run removeIdenticalField -F $'\t' 2 <<'EOF'
first	foo	blah
second	bar	blubb
third	foo	end
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	foo	blah
second	bar	blubb
third	foo	end" ]
}

@test "first field is omitted because it is identical" {
    run removeIdenticalField -F $'\t' 1 <<'EOF'
foo	first	blah
foo	second	blubb
foo	third	end
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	blah
second	blubb
third	end" ]
}

@test "last field is omitted because it is identical" {
    run removeIdenticalField -F $'\t' 3 <<'EOF'
first	blah	foo
second	blubb	foo
third	end	foo
EOF

    [ $status -eq 0 ]
    [ "$output" = "first	blah
second	blubb
third	end" ]
}
