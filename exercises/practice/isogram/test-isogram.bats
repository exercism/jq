#!/usr/bin/env bats
load bats-extra

@test "empty string" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "" }'
    assert_success
    assert_output true
}

@test "isogram with only lower case characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "isogram" }'
    assert_success
    assert_output true
}

@test "word with one duplicated character" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "eleven" }'
    assert_success
    assert_output false
}

@test "word with one duplicated character from the end of the alphabet" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "zzyzx" }'
    assert_success
    assert_output false
}

@test "longest reported english isogram" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "subdermatoglyphic" }'
    assert_success
    assert_output true
}

@test "word with duplicated character in mixed case" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "Alphabet" }'
    assert_success
    assert_output false
}

@test "word with duplicated character in mixed case, lowercase first" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "alphAbet" }'
    assert_success
    assert_output false
}

@test "hypothetical isogrammic word with hyphen" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "thumbscrew-japingly" }'
    assert_success
    assert_output true
}

@test "hypothetical word with duplicated character following hyphen" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "thumbscrew-jappingly" }'
    assert_success
    assert_output false
}

@test "isogram with duplicated hyphen" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "six-year-old" }'
    assert_success
    assert_output true
}

@test "made-up name that is an isogram" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "Emily Jung Schwartzkopf" }'
    assert_success
    assert_output true
}

@test "duplicated character in the middle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "accentor" }'
    assert_success
    assert_output false
}

@test "same first and last characters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "angola" }'
    assert_success
    assert_output false
}

@test "word with duplicated character and with two hyphens" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f isogram.jq <<< '{ "phrase": "up-to-date" }'
    assert_success
    assert_output false
}
