#!/usr/bin/env bats

@test "single field is omitted because it is identical" {
    run removeIdenticalField 1 <<'EOF'
foo
foo
foo
EOF

    [ $status -eq 0 ]
    [ "$output" = "" ]
}


@test "single field is not omitted because the second line is different" {
    run removeIdenticalField 1 <<'EOF'
foo
bar
foo
EOF

    [ $status -eq 0 ]
    [ "$output" = "foo
bar
foo" ]
}
