#!/usr/bin/env bats
load bats-extra
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

@test "Orange and orange and black" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f resistor-color-trio.jq <<< '["orange", "orange", "black"]'
    assert_success
    assert_output '{"value":33,"unit":"ohms"}'
}

@test "Blue and grey and brown" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f resistor-color-trio.jq <<< '["blue", "grey", "brown"]'
    assert_success
    assert_output '{"value":680,"unit":"ohms"}'
}

@test "Red and black and red" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f resistor-color-trio.jq <<< '["red", "black", "red"]'
    assert_success
    assert_output '{"value":2,"unit":"kiloohms"}'
}

@test "Green and brown and orange" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f resistor-color-trio.jq <<< '["green", "brown", "orange"]'
    assert_success
    assert_output '{"value":51,"unit":"kiloohms"}'
}

@test "Yellow and violet and yellow" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f resistor-color-trio.jq <<< '["yellow", "violet", "yellow"]'
    assert_success
    assert_output '{"value":470,"unit":"kiloohms"}'
}
