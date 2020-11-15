#!/usr/bin/env bats

@test "missing N|HEADER-NAME prints an error message" {
    run removeIdenticalField
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = "Usage:" ]
}
