#!/usr/bin/env bats
load bats-extra


@test "no name given" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

  # The above line controls whether to skip the test.
  # Normally, we skip every test except for the first one
  # (the first one is always commented out).  This allows for
  # a person to focus on solving a test at a time: you can
  # comment out or delete the
  # `[[ $BATS_RUN_SKIPPED == "true" ]] || skip`
  # line to run the test when you are ready.
  #
  # You can also run all the tests by setting the
  # `$BATS_RUN_SKIPPED` environment variable, like this:
  #
  #     $ BATS_RUN_SKIPPED=true bats test-two-fer.bats

  run jq -r -f two-fer.jq <<< '{"name": null}'
  assert_success
  assert_output "One for you, one for me."
}

@test "a name given" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f two-fer.jq <<< '{"name": "Alice"}'
  assert_success
  assert_output "One for Alice, one for me."
}

@test "another name given" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f two-fer.jq <<< '{"name": "Bob"}'
  assert_success
  assert_output "One for Bob, one for me."
}
