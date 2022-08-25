#!/usr/bin/env bats
load bats-extra

@test 'zero steps for one' {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r '
    import "./collatz-conjecture" as Collatz;
    .number | Collatz::steps
  ' <<< '{"number": 1}'

  assert_success
  assert_output "0"
}

@test "divide if even" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r '
    import "./collatz-conjecture" as Collatz;
    .number | Collatz::steps
  ' <<< '{"number": 16}'

  assert_success
  assert_output "4"
}

@test "even and odd steps" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r '
    import "./collatz-conjecture" as Collatz;
    .number | Collatz::steps
  ' <<< '{"number": 12}'

  assert_success
  assert_output "9"
}

@test "large number of even and odd steps" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r '
    import "./collatz-conjecture" as Collatz;
    .number | Collatz::steps
  ' <<< '{"number": 1000000}'

  assert_success
  assert_output "152"
}

@test "zero is an error" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r '
    import "./collatz-conjecture" as Collatz;
    .number | Collatz::steps
  ' <<< '{"number": 0}'

  assert_failure
  assert_output "Only positive integers are allowed"
}

@test "negative value is an error" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r '
    import "./collatz-conjecture" as Collatz;
    .number | Collatz::steps
  ' <<< '{"number": -15}'

  assert_failure
  assert_output "Only positive integers are allowed"
}
