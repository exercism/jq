#!/usr/bin/env bats
# generated on 2026-06-28T05:56:16+00:00
load bats-extra
load bats-jq

@test 'Say Hi!' {
    # [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -r -f hello-world.jq << 'END_INPUT'
        {}
END_INPUT

    assert_success
    expected='Hello, World!'
    assert_equal "$output" "$expected"
}
