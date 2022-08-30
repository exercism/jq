#!/usr/bin/env bats
load bats-extra

@test "empty strand" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f nucleotide-count.jq <<< '{ "strand": "" }'
    assert_success
    assert_output '{"A":0,"C":0,"G":0,"T":0}'
}

@test "can count one nucleotide in single-character input" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f nucleotide-count.jq <<< '{ "strand": "G" }'
    assert_success
    assert_output '{"A":0,"C":0,"G":1,"T":0}'
}

@test "strand with repeated nucleotide" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f nucleotide-count.jq <<< '{ "strand": "GGGGGGG" }'
    assert_success
    assert_output '{"A":0,"C":0,"G":7,"T":0}'
}

@test "strand with multiple nucleotides" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f nucleotide-count.jq <<< '{ "strand": "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC" }'
    assert_success
    assert_output '{"A":20,"C":12,"G":17,"T":21}'
}

@test "strand with invalid nucleotides" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f nucleotide-count.jq <<< '{ "strand": "AGXXACT" }'
    assert_failure
    assert_output 'Invalid nucleotide in strand'
}
