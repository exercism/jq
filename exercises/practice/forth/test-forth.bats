#!/usr/bin/env bats
load bats-extra

# parsing and numbers

@test "numbers just get pushed onto the stack" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 3 4 5"]
          }
END_INPUT
    assert_success
    assert_output "[1,2,3,4,5]"
}

@test "pushes negative numbers onto the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["-1 -2 -3 -4 -5"]
          }
END_INPUT
    assert_success
    assert_output "[-1,-2,-3,-4,-5]"
}

# addition

@test "can add two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 +"]
          }
END_INPUT
    assert_success
    assert_output "[3]"
}

@test "addition errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["+"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

@test "addition errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 +"]
          }
END_INPUT
    assert_failure
    assert_output --partial "only one value on the stack"
}

# subtraction

@test "can subtract two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["3 4 -"]
          }
END_INPUT
    assert_success
    assert_output "[-1]"
}

@test "subtraction errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["-"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

@test "subtraction errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 -"]
          }
END_INPUT
    assert_failure
    assert_output --partial "only one value on the stack"
}

# multiplication

@test "can multiply two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["2 4 *"]
          }
END_INPUT
    assert_success
    assert_output "[8]"
}

@test "multiplication errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["*"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

@test "multiplication errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 *"]
          }
END_INPUT
    assert_failure
    assert_output --partial "only one value on the stack"
}

# division

@test "can divide two numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["12 3 /"]
          }
END_INPUT
    assert_success
    assert_output "[4]"
}

@test "performs integer division" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["8 3 /"]
          }
END_INPUT
    assert_success
    assert_output "[2]"
}

@test "errors if dividing by zero" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["4 0 /"]
          }
END_INPUT
    assert_failure
    assert_output --partial "divide by zero"
}

@test "division errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["/"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

@test "division errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 /"]
          }
END_INPUT
    assert_failure
    assert_output --partial "only one value on the stack"
}

# combined arithmetic

@test "addition and subtraction" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 + 4 -"]
          }
END_INPUT
    assert_success
    assert_output "[-1]"
}

@test "multiplication and division" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["2 4 * 3 /"]
          }
END_INPUT
    assert_success
    assert_output "[2]"
}

# dup

@test "copies a value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 dup"]
          }
END_INPUT
    assert_success
    assert_output "[1,1]"
}

@test "copies the top value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 dup"]
          }
END_INPUT
    assert_success
    assert_output "[1,2,2]"
}

@test "dup errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["dup"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

# drop

@test "removes the top value on the stack if it is the only one" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 drop"]
          }
END_INPUT
    assert_success
    assert_output "[]"
}

@test "removes the top value on the stack if it is not the only one" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 drop"]
          }
END_INPUT
    assert_success
    assert_output "[1]"
}

@test "drop errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["drop"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

# swap

@test "swaps the top two values on the stack if they are the only ones" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 swap"]
          }
END_INPUT
    assert_success
    assert_output "[2,1]"
}

@test "swaps the top two values on the stack if they are not the only ones" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 3 swap"]
          }
END_INPUT
    assert_success
    assert_output "[1,3,2]"
}

@test "swap errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["swap"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

@test "swap errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 swap"]
          }
END_INPUT
    assert_failure
    assert_output --partial "only one value on the stack"
}

# over

@test "copies the second element if there are only two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 over"]
          }
END_INPUT
    assert_success
    assert_output "[1,2,1]"
}

@test "copies the second element if there are more than two" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 3 over"]
          }
END_INPUT
    assert_success
    assert_output "[1,2,3,2]"
}

@test "over errors if there is nothing on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["over"]
          }
END_INPUT
    assert_failure
    assert_output --partial "empty stack"
}

@test "over errors if there is only one value on the stack" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 over"]
          }
END_INPUT
    assert_failure
    assert_output --partial "only one value on the stack"
}

# user-defined words

@test "can consist of built-in words" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": dup-twice dup dup ;",
              "1 dup-twice"
            ]
          }
END_INPUT
    assert_success
    assert_output "[1,1,1]"
}

@test "execute in the right order" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": countup 1 2 3 ;",
              "countup"
            ]
          }
END_INPUT
    assert_success
    assert_output "[1,2,3]"
}

@test "can override other user-defined words" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": foo dup ;",
              ": foo dup dup ;",
              "1 foo"
            ]
          }
END_INPUT
    assert_success
    assert_output "[1,1,1]"
}

@test "can override built-in words" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": swap dup ;",
              "1 swap"
            ]
          }
END_INPUT
    assert_success
    assert_output "[1,1]"
}

@test "can override built-in operators" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": + * ;",
              "3 4 +"
            ]
          }
END_INPUT
    assert_success
    assert_output "[12]"
}

@test "can use different words with the same name" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": foo 5 ;",
              ": bar foo ;",
              ": foo 6 ;",
              "bar foo"
            ]
          }
END_INPUT
    assert_success
    assert_output "[5,6]"
}

@test "can define word that uses word with the same name" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": foo 10 ;",
              ": foo foo 1 + ;",
              "foo"
            ]
          }
END_INPUT
    assert_success
    assert_output "[11]"
}

@test "cannot redefine non-negative numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [": 1 2 ;"]
          }
END_INPUT
    assert_failure
    assert_output --partial "illegal operation"
}

@test "cannot redefine negative numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [": -1 2 ;"]
          }
END_INPUT
    assert_failure
    assert_output --partial "illegal operation"
}

@test "errors if executing a non-existent word" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["foo"]
          }
END_INPUT
    assert_failure
    assert_output --partial "undefined operation"
}

# case-insensitivity

@test "DUP is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 DUP Dup dup"]
          }
END_INPUT
    assert_success
    assert_output "[1,1,1,1]"
}

@test "DROP is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 3 4 DROP Drop drop"]
          }
END_INPUT
    assert_success
    assert_output "[1]"
}

@test "SWAP is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 SWAP 3 Swap 4 swap"]
          }
END_INPUT
    assert_success
    assert_output "[2,3,4,1]"
}

@test "OVER is case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": ["1 2 OVER Over over"]
          }
END_INPUT
    assert_success
    assert_output "[1,2,1,2,1]"
}

@test "user-defined words are case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": foo dup ;",
              "1 FOO Foo foo"
            ]
          }
END_INPUT
    assert_success
    assert_output "[1,1,1,1]"
}

@test "definitions are case-insensitive" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f forth.jq << END_INPUT
          {
            "instructions": [
              ": SWAP DUP Dup dup ;",
              "1 swap"
            ]
          }
END_INPUT
    assert_success
    assert_output "[1,1,1,1]"
}
