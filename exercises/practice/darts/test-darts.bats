#!/usr/bin/env bats
load bats-extra

@test "Missed target" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": -9, "y": 9 }'
    assert_success
    assert_output 0
}

@test "On the outer circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": 0, "y": 10 }'
    assert_success
    assert_output 1
}

@test "On the middle circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": -5, "y": 0 }'
    assert_success
    assert_output 5
}

@test "On the inner circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": 0, "y": -1 }'
    assert_success
    assert_output 10
}

@test "Exactly on centre" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": 0, "y": 0 }'
    assert_success
    assert_output 10
}

@test "Near the centre" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": -0.1, "y": -0.1 }'
    assert_success
    assert_output 10
}

@test "Just within the inner circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": 0.7, "y": 0.7 }'
    assert_success
    assert_output 10
}

@test "Just outside the inner circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": 0.8, "y": -0.8 }'
    assert_success
    assert_output 5
}

@test "Just within the middle circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": -3.5, "y": 3.5 }'
    assert_success
    assert_output 5
}

@test "Just outside the middle circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": -3.6, "y": -3.6 }'
    assert_success
    assert_output 1
}

@test "Just within the outer circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": -7.0, "y": 7.0 }'
    assert_success
    assert_output 1
}

@test "Just outside the outer circle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": 7.1, "y": -7.1 }'
    assert_success
    assert_output 0
}

@test "Asymmetric position between the inner and middle circles" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f darts.jq <<< '{ "x": 0.5, "y": -4 }'
    assert_success
    assert_output 5
}
