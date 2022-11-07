#!/usr/bin/env bats
load bats-extra

@test "first prime" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -n -f nth-prime.jq --argjson n 1
    assert_success
    assert_output 2
}

@test "second prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -n -f nth-prime.jq --argjson n 2
    assert_success
    assert_output 3
}

@test "sixth prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -n -f nth-prime.jq --argjson n 6
    assert_success
    assert_output 13
}

@test "big prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -n -f nth-prime.jq --argjson n 10001
    assert_success
    assert_output 104743
}

@test "there is no zeroth prime" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -n -f nth-prime.jq --argjson n 0
    assert_failure
    assert_output "there is no zeroth prime"
}
