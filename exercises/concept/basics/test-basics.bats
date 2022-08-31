#!/usr/bin/env bats
load bats-extra

setup() {
    cat > input.json <<'END_JSON'

{
  "exercise": "two-fer",
  "cases": [
    {
      "uuid": "1cf3e15a-a3d7-4a87-aeb3-ba1b43bc8dce",
      "description": "no name given",
      "property": "twoFer",
      "input": {
        "name": null
      },
      "expected": "One for you, one for me."
    },
    {
      "uuid": "b4c6dbb8-b4fb-42c2-bafd-10785abe7709",
      "description": "a name given",
      "property": "twoFer",
      "input": {
        "name": "Alice"
      },
      "expected": "One for Alice, one for me."
    },
    {
      "uuid": "3549048d-1a6e-4653-9a79-b0bda163e8d5",
      "description": "another name given",
      "property": "twoFer",
      "input": {
        "name": "Bob"
      },
      "expected": "One for Bob, one for me."
    }
  ]
}

END_JSON
}

teardown() {
    rm input.json
}

@test "Show exercise name" {
    ## task 1
    run jq -f basics.jq input.json
    assert_success
    assert_line --index 0 '"two-fer"'
}

@test "Show the description of the first case" {
    ## task 2
    run jq -f basics.jq input.json
    assert_success
    assert_line --index 1 '"no name given"'
}

@test "Show the input name of the last case" {
    ## task 3
    run jq -f basics.jq input.json
    assert_success
    assert_line --index 2 '"Bob"'
}

@test "Count the number of cases" {
    ## task 4
    run jq -f basics.jq input.json
    assert_success
    assert_line --index 3 '3'
}

@test "Show all the cases have property 'twoFer'" {
    ## task 5
    run jq -f basics.jq input.json
    assert_success
    assert_line --index 4 'true'
}
