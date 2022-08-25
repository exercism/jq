#!/usr/bin/env bats
load bats-extra

# populates a valid JSON file like:
#       {
#         "strand1": "some string",
#         "strand2": "some other string"
#       }
populate_test_file() {
    jq --arg strand1 "$1" \
       --arg strand2 "$2" \
       -n '$ARGS.named' > input.json
}

teardown() {
    rm -f input.json
}

@test 'empty strands' {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '' ''
  run jq -r -f hamming.jq input.json
  assert_success
  assert_output "0"
}

@test 'single letter identical strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'A' 'A'
  run jq -r -f hamming.jq input.json
  assert_success
  assert_output "0"
}

@test 'single letter different strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'G' 'T'
  run jq -r -f hamming.jq input.json
  assert_success
  assert_output "1"
}

@test 'long identical strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'GGACTGAAATCTG' 'GGACTGAAATCTG'
  run jq -r -f hamming.jq input.json
  assert_success
  assert_output "0"
}

@test 'long different strands' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'GGACGGATTCTG' 'AGGACGGATTCT'
  run jq -r -f hamming.jq input.json
  assert_success
  assert_output "9"
}

@test 'disallow first strand longer' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'AATG' 'AAA'
  run jq -r -f hamming.jq input.json
  assert_failure
  assert_output --partial "strands must be of equal length"
}

@test 'disallow second strand longer' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'ATA' 'AGTG'
  run jq -r -f hamming.jq input.json
  assert_failure
  assert_output --partial "strands must be of equal length"
}

@test 'disallow empty first strand' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file '' 'G'
  run jq -r -f hamming.jq input.json
  assert_failure
  assert_output --partial "strands must be of equal length"
}

@test 'disallow empty second strand' {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  populate_test_file 'G' ''
  run jq -r -f hamming.jq input.json
  assert_failure
  assert_output --partial "strands must be of equal length"
}
