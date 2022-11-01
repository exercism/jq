#!/usr/bin/env bats
# generated on 2022-11-01T19:48:58Z
load bats-extra

@test 'single letter' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f etl.jq <<'END_INPUT'
        {
          "legacy": {
            "1": [
              "A"
            ]
          }
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"a":1}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

@test 'single score with multiple letters' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f etl.jq <<'END_INPUT'
        {
          "legacy": {
            "1": [
              "A",
              "E",
              "I",
              "O",
              "U"
            ]
          }
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"a":1,"e":1,"i":1,"o":1,"u":1}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

@test 'multiple scores with multiple letters' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f etl.jq <<'END_INPUT'
        {
          "legacy": {
            "1": [
              "A",
              "E"
            ],
            "2": [
              "D",
              "G"
            ]
          }
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"a":1,"d":2,"e":1,"g":2}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

@test 'multiple scores with differing numbers of letters' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

    run jq -c -f etl.jq <<'END_INPUT'
        {
          "legacy": {
            "1": [
              "A",
              "E",
              "I",
              "O",
              "U",
              "L",
              "N",
              "R",
              "S",
              "T"
            ],
            "2": [
              "D",
              "G"
            ],
            "3": [
              "B",
              "C",
              "M",
              "P"
            ],
            "4": [
              "F",
              "H",
              "V",
              "W",
              "Y"
            ],
            "5": [
              "K"
            ],
            "8": [
              "J",
              "X"
            ],
            "10": [
              "Q",
              "Z"
            ]
          }
        }
END_INPUT

    assert_success
    expected=$(cat <<'END_EXPECTED'
{"a":1,"b":3,"c":3,"d":2,"e":1,"f":4,"g":2,"h":4,"i":1,"j":8,"k":5,"l":1,"m":3,"n":1,"o":1,"p":3,"q":10,"r":1,"s":1,"t":1,"u":1,"v":4,"w":4,"x":8,"y":4,"z":10}
END_EXPECTED
)
    assert_equal "$expected" "$output"
}

