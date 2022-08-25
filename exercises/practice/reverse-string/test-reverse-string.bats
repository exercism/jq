#!/usr/bin/env bats
load bats-extra

@test "an empty string" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f reverse-string.jq <<< '{"value": ""}'

  assert_success
  assert_output ""
}

@test "a word" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f reverse-string.jq <<< '{"value": "robot"}'

  assert_success
  assert_output "tobor"
}

@test "a capitalised word" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f reverse-string.jq <<< '{"value": "Ramen"}'

  assert_success
  assert_output "nemaR"
}

@test "a sentence with punctuation" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f reverse-string.jq <<< $'{"value": "I\'m hungry!"}'

  assert_success
  assert_output "!yrgnuh m'I"
}

@test "a palindrome" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f reverse-string.jq <<< '{"value": "racecar"}'

  assert_success
  assert_output "racecar"
}

@test "an even-sized word" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f reverse-string.jq <<< '{"value": "drawer"}'

  assert_success
  assert_output "reward"
}
