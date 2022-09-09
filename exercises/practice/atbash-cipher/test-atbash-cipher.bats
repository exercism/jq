#!/usr/bin/env bats
load bats-extra

@test "encode yes" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "yes"
      }
END_INPUT
    assert_success
    assert_output "bvh"
}

@test "encode no" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "no"
      }
END_INPUT
    assert_success
    assert_output "ml"
}

@test "encode OMG" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "OMG"
      }
END_INPUT
    assert_success
    assert_output "lnt"
}

@test "encode spaces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "O M G"
      }
END_INPUT
    assert_success
    assert_output "lnt"
}

@test "encode mindblowingly" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "mindblowingly"
      }
END_INPUT
    assert_success
    assert_output "nrmwy oldrm tob"
}

@test "encode numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "Testing,1 2 3, testing."
      }
END_INPUT
    assert_success
    assert_output "gvhgr mt123 gvhgr mt"
}

@test "encode deep thought" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "Truth is fiction."
      }
END_INPUT
    assert_success
    assert_output "gifgs rhurx grlm"
}

@test "encode all the letters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "encode",
        "phrase": "The quick brown fox jumps over the lazy dog."
      }
END_INPUT
    assert_success
    assert_output "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
}

@test "decode exercism" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "decode",
        "phrase": "vcvix rhn"
      }
END_INPUT
    assert_success
    assert_output "exercism"
}

@test "decode a sentence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "decode",
        "phrase": "zmlyh gzxov rhlug vmzhg vkkrm thglm v"
      }
END_INPUT
    assert_success
    assert_output "anobstacleisoftenasteppingstone"
}

@test "decode numbers" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "decode",
        "phrase": "gvhgr mt123 gvhgr mt"
      }
END_INPUT
    assert_success
    assert_output "testing123testing"
}

@test "decode all the letters" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "decode",
        "phrase": "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
      }
END_INPUT
    assert_success
    assert_output "thequickbrownfoxjumpsoverthelazydog"
}

@test "decode with too many spaces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "decode",
        "phrase": "vc vix    r hn"
      }
END_INPUT
    assert_success
    assert_output "exercism"
}

@test "decode with no spaces" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -r -f atbash-cipher.jq << END_INPUT
      {
        "property": "decode",
        "phrase": "zmlyhgzxovrhlugvmzhgvkkrmthglmv"
      }
END_INPUT
    assert_success
    assert_output "anobstacleisoftenasteppingstone"
}
