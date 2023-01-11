#!/usr/bin/env bats
load bats-extra

@test 'number to letter grade A' {
    ## task 1
    run jq -nc '
        include "grade-stats";
        [ range(90; 101) | letter_grade ]
    '
    assert_success
    assert_output '["A","A","A","A","A","A","A","A","A","A","A"]'
}

@test 'number to letter grade B' {
    ## task 1
    run jq -nc '
        include "grade-stats";
        [ range(80; 90) | letter_grade ]
    '
    assert_success
    assert_output '["B","B","B","B","B","B","B","B","B","B"]'
}

@test 'number to letter grade C' {
    ## task 1
    run jq -nc '
        include "grade-stats";
        [ range(70; 80) | letter_grade ]
    '
    assert_success
    assert_output '["C","C","C","C","C","C","C","C","C","C"]'
}

@test 'number to letter grade D' {
    ## task 1
    run jq -nc '
        include "grade-stats";
        [ range(60; 70) | letter_grade ]
    '
    assert_success
    assert_output '["D","D","D","D","D","D","D","D","D","D"]'
}

@test 'number to letter grade F' {
    ## task 1
    run jq -nc '
        include "grade-stats";
        [ range(0; 60) | letter_grade ]
        | (length == 60 and all(. == "F"))
    '
    assert_success
    assert_output 'true'
}

@test 'aggregate the number of students by letter grade' {
    ## task 2
    run jq -c '
        include "grade-stats";
        count_letter_grades
    ' grades.json
    assert_success
    assert_output '{"A":6,"B":1,"C":6,"D":2,"F":5}'
}
