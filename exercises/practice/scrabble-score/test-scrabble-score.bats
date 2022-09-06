#!/usr/bin/env bats
load bats-extra

@test 'lowercase letter' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'a'

    assert_success
    assert_output '1'
}

@test 'uppercase letter' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'A'

    assert_success
    assert_output '1'
}

@test 'valuable letter' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'f'

    assert_success
    assert_output '4'
}

@test 'short word' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'at'

    assert_success
    assert_output '2'
}

@test 'short, valuable word' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'zoo'

    assert_success
    assert_output '12'
}

@test 'medium word' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'street'

    assert_success
    assert_output '6'
}

@test 'medium, valuable word' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'quirky'

    assert_success
    assert_output '22'
}

@test 'long, mixed-case word' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'OxyphenButazone'

    assert_success
    assert_output '41'
}

@test 'english-like word' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'pinata'

    assert_success
    assert_output '8'
}

@test 'empty input' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< ''

    assert_success
    assert_output '0'
}

@test 'entire alphabet available' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'abcdefghijklmnopqrstuvwxyz'

    assert_success
    assert_output '87'
}

@test 'bonus: blank tile counts as zero' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq --raw-input -f scrabble-score.jq <<< 'abcdefghijklmnop rstuvwxyz'

    assert_success
    assert_output '77'
}
