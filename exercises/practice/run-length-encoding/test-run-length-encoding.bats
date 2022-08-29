#!/usr/bin/env bats
load bats-extra

# run-length encode a string

@test "encode: empty string" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | encode
    ' <<< '{ "string": "" }'

    assert_success
    assert_output '""'
}

@test "encode: single characters only are encoded without count" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | encode
    ' <<< '{ "string": "XYZ" }'

    assert_success
    assert_output '"XYZ"'
}

@test "encode: string with no single characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | encode
    ' <<< '{ "string": "AABBBCCCC" }'

    assert_success
    assert_output '"2A3B4C"'
}

@test "encode: single characters mixed with repeated characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | encode
    ' <<< '{ "string": "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" }'

    assert_success
    assert_output '"12WB12W3B24WB"'
}

@test "encode: multiple whitespace mixed in string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | encode
    ' <<< '{ "string": "  hsqq qww  " }'

    assert_success
    assert_output '"2 hs2q q2w2 "'
}

@test "encode: lowercase characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | encode
    ' <<< '{ "string": "aabbbcccc" }'

    assert_success
    assert_output '"2a3b4c"'
}

# run-length decode a string

@test "decode: empty string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | decode
    ' <<< '{ "string": "" }'

    assert_success
    assert_output '""'
}

@test "decode: single characters only" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | decode
    ' <<< '{ "string": "XYZ" }'

    assert_success
    assert_output '"XYZ"'
}

@test "decode: string with no single characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | decode
    ' <<< '{ "string": "2A3B4C" }'

    assert_success
    assert_output '"AABBBCCCC"'
}

@test "decode: single characters with repeated characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | decode
    ' <<< '{ "string": "12WB12W3B24WB" }'

    assert_success
    assert_output '"WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"'
}

@test "decode: multiple whitespace mixed in string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | decode
    ' <<< '{ "string": "2 hs2q q2w2 " }'

    assert_success
    assert_output '"  hsqq qww  "'
}

@test "decode: lowercase string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | decode
    ' <<< '{ "string": "2a3b4c" }'

    assert_success
    assert_output '"aabbbcccc"'
}

# encode and then decode

@test "encode followed by decode gives original string" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq '
        include "run-length-encoding";
        .string | encode | decode
    ' <<< '{ "string": "zzz ZZ  zZ" }'

    assert_success
    assert_output '"zzz ZZ  zZ"'
}
