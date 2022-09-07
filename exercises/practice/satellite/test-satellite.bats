#!/usr/bin/env bats
load bats-extra

@test "Empty tree" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f satellite.jq <<END_INPUT
      {
        "preorder": [],
        "inorder": []
      }
END_INPUT

    assert_success
    assert_output '{}'
}

@test "Tree with one item" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f satellite.jq <<END_INPUT
      {
        "preorder": ["a"],
        "inorder": ["a"]
      }
END_INPUT

    assert_success
    assert_output '{"v":"a","l":{},"r":{}}'
}

@test "Tree with many items" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f satellite.jq <<END_INPUT
      {
        "preorder": ["a", "i", "x", "f", "r"],
        "inorder": ["i", "a", "f", "x", "r"]
      }
END_INPUT

    expected=$(jq . <<END_INPUT
      {
        "v": "a",
        "l": { "v": "i", "l": {}, "r": {} },
        "r": {
          "v": "x",
          "l": { "v": "f", "l": {}, "r": {} },
          "r": { "v": "r", "l": {}, "r": {} }
        }
      }
END_INPUT
)

    assert_success
    assert_equal "$expected" "$output"
}

@test "Reject traversals of different length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f satellite.jq <<END_INPUT
      {
        "preorder": ["a", "b"],
        "inorder": ["b", "a", "r"]
      }
END_INPUT

    assert_failure
    assert_output "traversals must have the same length"
}

@test "Reject inconsistent traversals of same length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f satellite.jq <<END_INPUT
      {
        "preorder": ["x", "y", "z"],
        "inorder": ["a", "b", "c"]
      }
END_INPUT

    assert_failure
    assert_output "traversals must have the same elements"
}

@test "Reject traversals with repeated items" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f satellite.jq <<END_INPUT
      {
        "preorder": ["a", "b", "a"],
        "inorder": ["b", "a", "a"]
      }
END_INPUT

    assert_failure
    assert_output "traversals must contain unique items"
}
