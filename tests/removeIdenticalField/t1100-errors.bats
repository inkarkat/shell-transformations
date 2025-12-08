#!/usr/bin/env bats

load fixture

@test "missing N|HEADER-NAME prints an error message" {
    run -2 removeIdenticalField
    assert_line -n -1 -e "^Usage:"
}
