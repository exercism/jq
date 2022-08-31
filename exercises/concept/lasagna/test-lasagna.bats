#!/usr/bin/env bats
load bats-extra

# These tests use regex matching on the output text.
# Regex flavour is "bash" aka "POSIX extended"
# - https://www.gnu.org/software/gnulib/manual/html_node/posix_002dextended-regular-expression-syntax.html 
# - `\>` matches the end of a word

@test "Expected minutes in oven" {
    ## task 1
    run jq -f lasagna.jq --null-input
    assert_success
    assert_output --regexp '"expected_minutes_in_oven": 40\>'
}

@test "Calculate the remaining minutes in oven" {
    ## task 2
    run jq -f lasagna.jq <<-END_INPUT
	{
	  "actual_minutes_in_oven": 25
	}
	END_INPUT
    assert_success
    assert_output --regexp '"remaining_minutes_in_oven": 15\>'
}

@test "Calculate the remaining minutes in oven, not yet started" {
    ## task 2
    run jq -f lasagna.jq --null-input
    assert_success
    assert_output --regexp '"remaining_minutes_in_oven": 40\>'
}

@test "Calculate the preparation time with one layer" {
    ## task 3
    run jq -f lasagna.jq <<-END_INPUT
	{
	  "number_of_layers": 1
	}
	END_INPUT
    assert_success
    assert_output --regexp '"preparation_time": 2\>'
}

@test "Calculate the preparation time with four layers" {
    ## task 3
    run jq -f lasagna.jq <<-END_INPUT
	{
	  "number_of_layers": 4
	}
	END_INPUT
    assert_success
    assert_output --regexp '"preparation_time": 8\>'
}

@test "Total time elapsed with one layers" {
    ## task 4
    run jq -f lasagna.jq <<-END_INPUT
	{
	  "actual_minutes_in_oven": 30,
	  "number_of_layers": 1
	}
	END_INPUT
    assert_success
    assert_output --regexp '"total_time": 32\>'
}

@test "Total time elapsed with four layers" {
    ## task 4
    run jq -f lasagna.jq <<-END_INPUT
	{
	  "number_of_layers": 4,
	  "actual_minutes_in_oven": 10
	}
	END_INPUT
    assert_success
    assert_output --regexp '"total_time": 18\>'
}
