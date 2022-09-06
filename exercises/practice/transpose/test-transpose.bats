#!/usr/bin/env bats
load bats-extra

# We use the `-s` jq option here.  This is the `--slurp` option:
# - all inputs are collected into a single array,
# - that array is the input to the filter.


@test "empty string" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -s -f transpose.jq <<< ''
    assert_success
    assert_output '[]'
}


@test "two characters in a row" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"A1"
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "A",
  "1"
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "two characters in a column" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"A"
"1"
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "A1"
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "simple" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"ABC"
"123"
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "A1",
  "B2",
  "C3"
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "single line" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"Single line."
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "S",
  "i",
  "n",
  "g",
  "l",
  "e",
  " ",
  "l",
  "i",
  "n",
  "e",
  "."
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "first line longer than second line" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"The fourth line."
"The fifth line."
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "TT",
  "hh",
  "ee",
  "  ",
  "ff",
  "oi",
  "uf",
  "rt",
  "th",
  "h ",
  " l",
  "li",
  "in",
  "ne",
  "e.",
  "."
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "second line longer than first line" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"The first line."
"The second line."
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "TT",
  "hh",
  "ee",
  "  ",
  "fs",
  "ie",
  "rc",
  "so",
  "tn",
  " d",
  "l ",
  "il",
  "ni",
  "en",
  ".e",
  " ."
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "mixed line length" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"The longest line."
"A long line."
"A longer line."
"A line."
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "TAAA",
  "h   ",
  "elll",
  " ooi",
  "lnnn",
  "ogge",
  "n e.",
  "glr",
  "ei ",
  "snl",
  "tei",
  " .n",
  "l e",
  "i .",
  "n",
  "e",
  "."
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "square" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"HEART"
"EMBER"
"ABUSE"
"RESIN"
"TREND"
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "HEART",
  "EMBER",
  "ABUSE",
  "RESIN",
  "TREND"
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "rectangle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"FRACTURE"
"OUTLINED"
"BLOOMING"
"SEPTETTE"
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "FOBS",
  "RULE",
  "ATOP",
  "CLOT",
  "TIME",
  "UNIT",
  "RENT",
  "EDGE"
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "triangle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"T"
"EE"
"AAA"
"SSSS"
"EEEEE"
"RRRRRR"
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "TEASER",
  " EASER",
  "  ASER",
  "   SER",
  "    ER",
  "     R"
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}


@test "jagged triangle" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip

input=$(cat <<END_INPUT
"11"
"2"
"3333"
"444"
"555555"
"66666"
END_INPUT
)

expected=$(cat <<END_EXPECTED
[
  "123456",
  "1 3456",
  "  3456",
  "  3 56",
  "    56",
  "    5"
]
END_EXPECTED
)

    run jq -s -f transpose.jq <<<"$input"
    assert_success
    assert_equal "$expected" "$output"
}
