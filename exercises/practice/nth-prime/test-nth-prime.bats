#!/usr/bin/env bats
# generated on 2022-11-02T20:59:29Z
load bats-extra

@test 'first prime' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -r -f nth-prime.jq << 'END_INPUT'
        {
          "number": 1
        }
END_INPUT

    assert_success
    expected=2
    assert_equal "$expected" "$output"
}

@test 'second prime' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -r -f nth-prime.jq << 'END_INPUT'
        {
          "number": 2
        }
END_INPUT

    assert_success
    expected=3
    assert_equal "$expected" "$output"
}

@test 'sixth prime' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -r -f nth-prime.jq << 'END_INPUT'
        {
          "number": 6
        }
END_INPUT

    assert_success
    expected=13
    assert_equal "$expected" "$output"
}

@test 'big prime' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -r -f nth-prime.jq << 'END_INPUT'
        {
          "number": 10001
        }
END_INPUT

    assert_success
    expected=104743
    assert_equal "$expected" "$output"
}

@test 'there is no zeroth prime' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -r -f nth-prime.jq << 'END_INPUT'
        {
          "number": 0
        }
END_INPUT

    assert_failure
    expected='there is no zeroth prime'
    assert_equal "$expected" "$output"
}

