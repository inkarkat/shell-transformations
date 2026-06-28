#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 truncateLongTail
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 truncateLongTail --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 2 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 truncateLongTail -h
    refute_line -n 0 -e '^Usage:'
}
