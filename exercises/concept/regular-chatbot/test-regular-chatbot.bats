#!/usr/bin/env bats
load bats-extra

#import {
#  isValidCommand,
#  removeEmoji,
#  checkPhoneNumber,
#  getURL,
#  niceToMeetYou,
#} from './regular-chatbot';

@test 'recognizes a command at the first position' {
    ## task 1
    run jq -R '
        include "regular-chatbot";
        isValidCommand
    ' <<< 'Chatbot, Do you understand this command?'
    assert_success
    assert_output true
}

@test 'does not recognize a command if not at the first position' {
    ## task 1
    run jq -R '
        include "regular-chatbot";
        isValidCommand
    ' <<< 'Hey Chatbot, please tell me what is the weather for tomorrow.'
    assert_success
    assert_output false
}

@test 'does not care about UPPERCASE or lowercase' {
    ## task 1
    run jq -R '
        include "regular-chatbot";
        isValidCommand
    ' << END_INPUT
CHATBOT, Is it okey if I shout at you?
chatbot, please tell me what is happening here.
END_INPUT
    assert_success
    assert_equal 2 "${#lines[@]}"
    assert_line --index 0 true
    assert_line --index 1 true
}

@test 'removes properly one single emoji encryption' {
    ## task 2
    run jq -Rr '
        include "regular-chatbot";
        removeEmoji
    ' <<< 'What was your name? emoji2134 Sorry I forgot about it.'
    assert_success
    assert_output 'What was your name?  Sorry I forgot about it.'
}

@test 'removes all the emoji encryption' {
    ## task 2
    run jq -Rr '
        include "regular-chatbot";
        removeEmoji
    ' <<< 'emoji5321 How about ordering emoji8921 ?'
    assert_success
    assert_output ' How about ordering  ?'
}

@test 'recognizes a phone number with the correct format' {
    ## task 3
    run jq -Rr '
        include "regular-chatbot";
        checkPhoneNumber
    ' <<< '(+34) 643-876-459'
    assert_success
    assert_output 'Thanks! You can now download me to your phone.'
}

@test 'recognizes a phone number with another correct format' {
    run jq -Rr '
        include "regular-chatbot";
        checkPhoneNumber
    ' <<< '(+49) 543-928-190'
    assert_success
    assert_output 'Thanks! You can now download me to your phone.'
}

@test 'informs the user that it is a wrong phone number format' {
    ## task 3
    run jq -rn '
        include "regular-chatbot";
        "322-787-654" | checkPhoneNumber
    '
    assert_success
    assert_output "Oops, it seems like I can't reach out to 322-787-654"
}

@test 'informs the user that it is another wrong phone number format' {
    ## task 3
    run jq -rn '
        include "regular-chatbot";
        "4355-67-274" | checkPhoneNumber
    '
    assert_success
    assert_output "Oops, it seems like I can't reach out to 4355-67-274"
}

@test 'returns only the link of the website' {
    ## task 4
    run jq -Rr '
        include "regular-chatbot";
        getURL
    ' <<< 'You can check more info on youtube.com'
    assert_success
    assert_output 'youtube.com'
}

@test 'returns only the link of another website' {
    ## task 4
    run jq -Rr '
        include "regular-chatbot";
        getURL
    ' <<< 'There is a cool website called theodinproject.com to learn from'
    assert_success
    assert_output 'theodinproject.com'
}

@test 'returns a stream of multiple websites links' {
    ## task 4
    run jq -Rr '
        include "regular-chatbot";
        getURL
    ' <<< 'That was from reddit.com and notion.so'
    assert_success
    assert_equal 2 "${#lines[@]}"
    assert_line --index 0 'reddit.com'
    assert_line --index 1 'notion.so'
}

@test 'greets the user by their proper name' {
    ## task 5
    run jq -rn '
        include "regular-chatbot";
        "my name is Pablo and I am six years old" | niceToMeetYou
    '
    assert_success
    assert_output 'Nice to meet you, Pablo'
}

@test 'greets another user by their proper name' {
    ## task 5
    run jq -rn '
        include "regular-chatbot";
        "Hello Chatbot, my name is Marie-Claire" | niceToMeetYou
    '
    assert_success
    assert_output 'Nice to meet you, Marie-Claire'
}
