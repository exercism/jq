#!/usr/bin/env bats
load bats-extra

@test "zebra-puzzle" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -n -f zebra-puzzle.jq
    assert_success
    assert_line --partial '"drinksWater": "Norwegian"'
    assert_line --partial '"ownsZebra": "Japanese"'
}
