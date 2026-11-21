#!/usr/bin/env bats
load bats-extra
load bats-jq

# The mysterious external library is represented by mock
# implementations of the `fodder_amount` and `fattening_factor`
# functions, provided by each test.

@test "calculate the amount of food per cow" {
    ## task 1
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        5 | divide_food(fodder_amount; fattening_factor)
    '
    assert_success
    assert_output "15"
}

@test "calculate the amount of food per cow, another example" {
    ## task 1
    run jq -n '
        include "the-farm";
        def fodder_amount: 144;
        def fattening_factor: 2.5;
        9 | divide_food(fodder_amount; fattening_factor)
    '
    assert_success
    assert_output "40"
}

@test "an error from the fodder_amount function is propagated" {
    ## task 1
    run jq -n '
        include "the-farm";
        def fodder_amount: error("fodder machine broke");
        def fattening_factor: 1.5;
        5 | divide_food(fodder_amount; fattening_factor)
    '
    assert_failure
    assert_output --partial "fodder machine broke"
}

@test "an error from the fattening_factor function is propagated" {
    ## task 1
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: error("scales are kaput");
        5 | divide_food(fodder_amount; fattening_factor)
    '
    assert_failure
    assert_output --partial "scales are kaput"
}

@test "a structured error from the library is propagated unchanged" {
    ## task 1
    run jq -c -n '
        include "the-farm";
        def fodder_amount: error({machine: "FEED-M-ALL", code: 42});
        def fattening_factor: 1.5;
        5 | try divide_food(fodder_amount; fattening_factor) catch .
    '
    assert_success
    assert_output '{"machine":"FEED-M-ALL","code":42}'
}

@test "valid input is divided as before" {
    ## task 2
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        5 | validate_input_and_divide_food(fodder_amount; fattening_factor)
    '
    assert_success
    assert_output "15"
}

@test "zero cows is an error" {
    ## task 2
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        0 | validate_input_and_divide_food(fodder_amount; fattening_factor)
    '
    assert_failure
    assert_output --partial "invalid number of cows"
}

@test "negative cows is an error" {
    ## task 2
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        -10 | try validate_input_and_divide_food(fodder_amount; fattening_factor) catch .
    '
    assert_success
    assert_output '"invalid number of cows"'
}

@test "the library is not consulted for invalid input" {
    ## task 2
    run jq -n '
        include "the-farm";
        def fodder_amount: error("the library should not be called");
        def fattening_factor: error("the library should not be called");
        0 | try validate_input_and_divide_food(fodder_amount; fattening_factor) catch .
    '
    assert_success
    assert_output '"invalid number of cows"'
}

@test "negative cows raises a structured error" {
    ## task 3
    run jq -c -n '
        include "the-farm";
        -5 | try validate_number_of_cows catch .
    '
    assert_success
    assert_output '{"cows":-5,"message":"there are no negative cows"}'
}

@test "zero cows raises a structured error" {
    ## task 3
    run jq -c -n '
        include "the-farm";
        0 | try validate_number_of_cows catch .
    '
    assert_success
    assert_output '{"cows":0,"message":"no cows don'"'"'t need food"}'
}

@test "the structured error is raised, not output" {
    ## task 3
    run jq -n '
        include "the-farm";
        -1 | validate_number_of_cows
    '
    assert_failure
    assert_output --partial '{"cows":-1,"message":"there are no negative cows"}'
}

@test "a valid number of cows passes validation" {
    ## task 3
    run jq -n '
        include "the-farm";
        12 | validate_number_of_cows
    '
    assert_success
    assert_output "12"
}

@test "feed the cows when the input is valid" {
    ## task 4
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        5 | feed_cows(fodder_amount; fattening_factor)
    '
    assert_success
    assert_output "15"
}

@test "a negative number of cows is reported with a friendly message" {
    ## task 4
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        -5 | try feed_cows(fodder_amount; fattening_factor) catch .
    '
    assert_success
    assert_output '"-5 cows are invalid: there are no negative cows"'
}

@test "zero cows is reported with a friendly message" {
    ## task 4
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        0 | try feed_cows(fodder_amount; fattening_factor) catch .
    '
    assert_success
    assert_output '"0 cows are invalid: no cows don'"'"'t need food"'
}

@test "the friendly message is raised as an error, not output" {
    ## task 4
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        -1 | feed_cows(fodder_amount; fattening_factor)
    '
    assert_failure
    assert_output --partial "-1 cows are invalid: there are no negative cows"
}

@test "library errors are still propagated" {
    ## task 4
    run jq -n '
        include "the-farm";
        def fodder_amount: error("fodder machine broke");
        def fattening_factor: 1.5;
        5 | feed_cows(fodder_amount; fattening_factor)
    '
    assert_failure
    assert_output --partial "fodder machine broke"
}

@test "lenient division uses the fattening factor when it works" {
    ## task 5
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: 1.5;
        5 | divide_food_leniently(fodder_amount; fattening_factor)
    '
    assert_success
    assert_output "15"
}

@test "lenient division falls back to a factor of 1 when the scales fail" {
    ## task 5
    run jq -n '
        include "the-farm";
        def fodder_amount: 50;
        def fattening_factor: error("scales are kaput");
        5 | divide_food_leniently(fodder_amount; fattening_factor)
    '
    assert_success
    assert_output "10"
}

@test "the fallback factor is exactly 1" {
    ## task 5
    run jq -n '
        include "the-farm";
        def fodder_amount: 44;
        def fattening_factor: error("scales are kaput");
        4 | divide_food_leniently(fodder_amount; fattening_factor)
    '
    assert_success
    assert_output "11"
}

@test "lenient division still propagates errors from the fodder_amount function" {
    ## task 5
    run jq -n '
        include "the-farm";
        def fodder_amount: error("fodder machine broke");
        def fattening_factor: error("scales are kaput");
        5 | divide_food_leniently(fodder_amount; fattening_factor)
    '
    assert_failure
    assert_output --partial "fodder machine broke"
}

# vim: sw=4 ts=8
