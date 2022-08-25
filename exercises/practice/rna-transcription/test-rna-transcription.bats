#!/usr/bin/env bats
load bats-extra

@test "Empty RNA sequence" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r 'include "./rna-transcription"; .dna | toRna' <<< '{"dna": ""}'
  assert_success
  assert_output ""
}

@test "RNA complement of cytosine is guanine" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r 'include "./rna-transcription"; .dna | toRna' <<< '{"dna": "C"}'
  assert_success
  assert_output "G"
}

@test "RNA complement of guanine is cytosine" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r 'include "./rna-transcription"; .dna | toRna' <<< '{"dna": "G"}'
  assert_success
  assert_output "C"
}

@test "RNA complement of thymine is adenine" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r 'include "./rna-transcription"; .dna | toRna' <<< '{"dna": "T"}'
  assert_success
  assert_output "A"
}

@test "RNA complement of adenine is uracil" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r 'include "./rna-transcription"; .dna | toRna' <<< '{"dna": "A"}'
  assert_success
  assert_output "U"
}

@test "RNA complement" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r 'include "./rna-transcription"; .dna | toRna' <<< '{"dna": "ACGTGGTCTTAA"}'
  assert_success
  assert_output "UGCACCAGAAUU"
}
