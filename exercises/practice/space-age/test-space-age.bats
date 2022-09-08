#!/usr/bin/env bats
load bats-extra

@test "age on Earth" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Earth",
        "seconds": 1000000000
      }
END_INPUT

    assert_success
    assert_output 31.69
}

@test "age on Mercury" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Mercury",
        "seconds": 2134835688
      }
END_INPUT

    assert_success
    assert_output 280.88
}

@test "age on Venus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Venus",
        "seconds": 189839836
      }
END_INPUT

    assert_success
    assert_output 9.78
}

@test "age on Mars" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Mars",
        "seconds": 2129871239
      }
END_INPUT

    assert_success
    assert_output 35.88
}

@test "age on Jupiter" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Jupiter",
        "seconds": 901876382
      }
END_INPUT

    assert_success
    assert_output 2.41
}

@test "age on Saturn" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Saturn",
        "seconds": 2000000000
      }
END_INPUT

    assert_success
    assert_output 2.15
}

@test "age on Uranus" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Uranus",
        "seconds": 1210123456
      }
END_INPUT

    assert_success
    assert_output 0.46
}

@test "age on Neptune" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Neptune",
        "seconds": 1821023456
      }
END_INPUT

    assert_success
    assert_output 0.35
}

@test "invalid planet causes error" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -f space-age.jq <<END_INPUT
      {
        "planet": "Sun",
        "seconds": 680804807
      }
END_INPUT

    assert_failure
    assert_output "not a planet"
}
