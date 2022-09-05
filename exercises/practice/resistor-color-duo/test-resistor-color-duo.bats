#!/usr/bin/env bats
load bats-extra

@test "Brown and black" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color-duo.jq <<< '["brown", "black"]'
    assert_success
    assert_output 10
}

@test "Blue and grey" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color-duo.jq <<< '["blue", "grey"]'
    assert_success
    assert_output 68
}

@test "Yellow and violet" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color-duo.jq <<< '["yellow", "violet"]'
    assert_success
    assert_output 47
}

@test "White and red" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color-duo.jq <<< '["white", "red"]'
    assert_success
    assert_output 92
}

@test "Orange and orange" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color-duo.jq <<< '["orange", "orange"]'
    assert_success
    assert_output 33
}

@test "Ignore additional colors" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color-duo.jq <<< '["green", "brown", "orange"]'
    assert_success
    assert_output 51
}

@test "Black and brown, one-digit" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color-duo.jq <<< '["black", "brown"]'
    assert_success
    assert_output 1
}
