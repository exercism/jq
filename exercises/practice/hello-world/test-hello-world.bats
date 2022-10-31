#!/usr/bin/env bats
# generated on 2022-10-31T20:42:44Z
load bats-extra

@test 'Say Hi!' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -r -f hello-world.jq <<END_INPUT
        {}
END_INPUT

    assert_success

    actual=$output
    expected='Hello, World!'
    assert_equal "$expected" "$actual"
}

