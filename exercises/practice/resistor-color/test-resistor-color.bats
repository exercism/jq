#!/usr/bin/env bats
load bats-extra

@test "Black" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color.jq <<END_INPUT
        {
          "property": "colorCode",
          "input": {
            "color": "black"
          }
        }
END_INPUT

    assert_success
    assert_output 0
}

@test "White" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color.jq <<END_INPUT
        {
          "property": "colorCode",
          "input": {
            "color": "white"
          }
        }
END_INPUT

    assert_success
    assert_output 9
}

@test "Orange" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f resistor-color.jq <<END_INPUT
        {
          "property": "colorCode",
          "input": {
            "color": "orange"
          }
        }
END_INPUT

    assert_success
    assert_output 3
}

@test "Colors" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f resistor-color.jq <<END_INPUT
        {
          "property": "colors",
          "input": {}
        }
END_INPUT

    assert_success
    assert_output '["black","brown","red","orange","yellow","green","blue","violet","grey","white"]'
}
