#!/usr/bin/env bats
# generated on 2022-11-01T19:49:24Z
load bats-extra

@test 'empty strand' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f nucleotide-count.jq <<'END_INPUT'
        {
          "strand": ""
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"A":0,"C":0,"G":0,"T":0}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

@test 'can count one nucleotide in single-character input' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f nucleotide-count.jq <<'END_INPUT'
        {
          "strand": "G"
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"A":0,"C":0,"G":1,"T":0}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

@test 'strand with repeated nucleotide' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f nucleotide-count.jq <<'END_INPUT'
        {
          "strand": "GGGGGGG"
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"A":0,"C":0,"G":7,"T":0}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

@test 'strand with multiple nucleotides' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f nucleotide-count.jq <<'END_INPUT'
        {
          "strand": "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"A":20,"C":12,"G":17,"T":21}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

@test 'strand with invalid nucleotides' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f nucleotide-count.jq <<'END_INPUT'
        {
          "strand": "AGXXACT"
        }
END_INPUT

    assert_failure
    expected='Invalid nucleotide in strand'
    assert_equal "$expected" "$output"
}

