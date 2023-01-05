# Instructions

You have been hired as a Regular Expression Specialist in a company that is developing a Chatbot.

It is in a very basic phase of development, hence your mission is to use Regular Expressions to improve the chatbot's ability to understand and generate natural language.

## Check Valid Command

Apart from being smart, the Chatbot is also a loyal assistant.

To ask something to the chatbot, the user must say the word “**Chatbot**” in the first position of the command.

It doesn't matter if the keyword is in UPPERCASE or lowercase. The important aspect here is the position of the word.

Implement the function `is_valid_command` that helps the Chatbot recognize when the user is giving a command.

```jq
"Chatbot, play a song from the 80's." | is_valid_command
# => true
"Hey Chatbot, where is the closest pharmacy?" | is_valid_command
# => false
"CHATBOT, do you have a solution for this challenge?" | is_valid_command
# => true
```

## Remove encrypted emojis

The Chatbot has a difficult time understanding how humans use emojis to express their emotions.

When the chatbot receives user messages, each emoji is represented as the letters "emoji" followed by an _id number_.

Implement the `remove_emoji` method to take a string and remove all the emoji throughout the message.

Lines not containing emojis should be returned unmodified.

Just remove the emoji string. Do not attempt to adjust the whitespace.

For this particular challenge, use constructor syntax for creating the regular expression.

```jq
"I love playing videogames emoji3465 it's one of my hobbies" | remove_emoji
# => "I love playing videogames  it's one of my hobbies"
```

## Check Valid Phone Number

Considering the download of chatbot features on a mobile app, the user is expected to write a phone number during the conversation.

The problem is that the chatbot can only read and validate a number with a specific format.

Implement the `check_phone_number` function.
If the number is valid, the chatbot answers with a message thanking the user and confirming the number.
If the number is invalid, the function informs the user that the phone number is not valid.

The expected format is `(+NN) NNN-NNN-NNN`, where N is a digit.

```jq
"(+34) 659-771-594" | check_phone_number
# => "Thanks! You can now download me to your phone."
"659-771-594" | check_phone_number
# => "Oops, it seems like I can't reach out to 659-771-594"
```

## Get website link

The Chatbot is a really curious software.
Even though it can search on the internet about a particular topic, it likes to ask users about cool websites or URLs to go find relevant information.

Example of Conversation:

> **Chatbot**: Hey User, I would like to learn how to code in JavaScript, do you know any cool website where I could learn?

> **User**: I learned a lot from exercism.org, there's lots of great stuff there.

Implement the function `get_url` which is able to return an array with just the domain of each website.

```jq
"I learned a lot from exercism.org and google.com" | get_url
# => ["exercism.org", "google.com"]
```

## Greet the user

A polite chatbot will speak to users by name.
When a user introduces themselves, our Chatbot will detect their name and respond with a friendly greeting.

Write the function `nice_to_meet_you`.
If the input string contains "my name is Someone", capture the name and return the string "Nice to meet you, Someone".

```jq
"My name is Jean-Luc" | nice_to_meet_you
# => "Nice to meet you, Jean-Luc"
```

## Very simple CSV parsing

Yielding to "creeping featuritis", we'll add a CSV parsing function to the Chatbot. 

Implement the `parse_csv` function that takes a string and returns an array of the resulting field data.
The field separator will be defined as "comma plus optional whitespace". 

We won't worry about any of the edge cases with the CSV format (such as fields containing commas).

```jq
"first, second,third,   fourth" | parse_csv
# => ["first", "second", "third", "fourth"]
```
