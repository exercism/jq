#!/usr/bin/env bats
load bats-extra

@test "Empty RNA sequence results in no proteins" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": ""}'
    assert_success
    assert_output '[]'
}

@test "Methionine RNA sequence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "AUG"}'
    assert_success
    assert_output '["Methionine"]'
}

@test "Phenylalanine RNA sequence 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UUU"}'
    assert_success
    assert_output '["Phenylalanine"]'
}

@test "Phenylalanine RNA sequence 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UUC"}'
    assert_success
    assert_output '["Phenylalanine"]'
}

@test "Leucine RNA sequence 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UUA"}'
    assert_success
    assert_output '["Leucine"]'
}

@test "Leucine RNA sequence 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UUG"}'
    assert_success
    assert_output '["Leucine"]'
}

@test "Serine RNA sequence 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UCU"}'
    assert_success
    assert_output '["Serine"]'
}

@test "Serine RNA sequence 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UCC"}'
    assert_success
    assert_output '["Serine"]'
}

@test "Serine RNA sequence 3" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UCA"}'
    assert_success
    assert_output '["Serine"]'
}

@test "Serine RNA sequence 4" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UCG"}'
    assert_success
    assert_output '["Serine"]'
}

@test "Tyrosine RNA sequence 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UAU"}'
    assert_success
    assert_output '["Tyrosine"]'
}

@test "Tyrosine RNA sequence 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UAC"}'
    assert_success
    assert_output '["Tyrosine"]'
}

@test "Cysteine RNA sequence 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UGU"}'
    assert_success
    assert_output '["Cysteine"]'
}

@test "Cysteine RNA sequence 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UGC"}'
    assert_success
    assert_output '["Cysteine"]'
}

@test "Tryptophan RNA sequence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UGG"}'
    assert_success
    assert_output '["Tryptophan"]'
}

@test "STOP codon RNA sequence 1" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UAA"}'
    assert_success
    assert_output '[]'
}

@test "STOP codon RNA sequence 2" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UAG"}'
    assert_success
    assert_output '[]'
}

@test "STOP codon RNA sequence 3" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UGA"}'
    assert_success
    assert_output '[]'
}

@test "Sequence of two protein codons translates into proteins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UUUUUU"}'
    assert_success
    assert_output '["Phenylalanine","Phenylalanine"]'
}

@test "Sequence of two different protein codons translates into proteins" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UUAUUG"}'
    assert_success
    assert_output '["Leucine","Leucine"]'
}

@test "Translate RNA strand into correct protein list" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "AUGUUUUGG"}'
    assert_success
    assert_output '["Methionine","Phenylalanine","Tryptophan"]'
}

@test "Translation stops if STOP codon at beginning of sequence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UAGUGG"}'
    assert_success
    assert_output '[]'
}

@test "Translation stops if STOP codon at end of two-codon sequence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UGGUAG"}'
    assert_success
    assert_output '["Tryptophan"]'
}

@test "Translation stops if STOP codon at end of three-codon sequence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "AUGUUUUAA"}'
    assert_success
    assert_output '["Methionine","Phenylalanine"]'
}

@test "Translation stops if STOP codon in middle of three-codon sequence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UGGUAGUGG"}'
    assert_success
    assert_output '["Tryptophan"]'
}

@test "Translation stops if STOP codon in middle of six-codon sequence" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UGGUGUUAUUAAUGGUUU"}'
    assert_success
    assert_output '["Tryptophan","Cysteine","Tyrosine"]'
}

@test "Non-existing codon can't translate: ignore them" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "AAA"}'
    assert_success
    assert_output '[]'
}

@test "Unknown amino acids, not part of a codon, can't translate: ignore them" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "XYZ"}'
    assert_success
    assert_output '[]'
}

@test "Ignore incomplete RNA sequence can't translate" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "AUGU"}'
    assert_success
    assert_output '["Methionine"]'
}

@test "Ignore incomplete RNA sequence after a STOP codon" {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run jq -c -f protein-translation.jq <<< '{"strand": "UUCUUCUAAUGGU"}'
    assert_success
    assert_output '["Phenylalanine","Phenylalanine"]'
}
