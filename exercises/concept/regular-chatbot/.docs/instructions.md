# Instructions

You have been hired as a Regular Expression Specialist in a company that is developing a Chatbot.

It is in a very basic phase of development.
Your mission is to use Regular Expressions to improve the Chatbot's ability to understand and generate natural language.

## Check Valid Command

Apart from being smart, the Chatbot is also a loyal assistant.
To ask the Chatbot something, the user must say the word "**Chatbot**" in the first position of the command.
It doesn't matter if the keyword is in UPPERCASE or lowercase.
The important part is the position of the word.

Implement the function `is_valid_command` that helps the Chatbot recognize when the user is giving a command.

```jq
"Chatbot, play a song from the 80's." | is_valid_command
# => true
"Hey Chatbot, where is the closest pharmacy?" | is_valid_command
# => false
"CHATBOT, do you have a solution for this challenge?" | is_valid_command
# => true
```

## Remove Encrypted Emojis

The Chatbot has a difficult time understanding how humans use emojis to express their emotions.
When the Chatbot receives user messages, each emoji is represented as the string "emoji" followed by an _id number_.

Implement the `remove_emoji` method which takes a string and removes all the emoji throughout the message.

Lines not containing emojis should be returned unmodified.
Just remove the emoji string.
Do not adjust the whitespace.

```jq
"I love playing videogames emoji3465 it's one of my hobbies" | remove_emoji
# => "I love playing videogames  it's one of my hobbies"
```

## Check Valid Phone Number

At some point in the interaction with the Chatbot, the user will provide a phone number.
The Chatbot can only call a number with a specific format.

Implement the `check_phone_number` function.

If the number is valid, the Chatbot answers with a message thanking the user and confirming the number.
If the number is invalid, the Chatbot informs the user that the phone number is not valid.

The expected format is `(+NN) NNN-NNN-NNN`, where N is a digit.

```jq
"chatbot my phone number is (+34) 659-771-594" | check_phone_number
# => "Thanks! Your phone number is OK."
"chatbot, call me at 659-771-594" | check_phone_number
# => "Oops, it seems like I can't reach out to 659-771-594."
```

## Get Website Link

The Chatbot is a really curious software.
Even though it can search the internet for a particular topic, it likes to ask users about cool websites to visit to find relevant information.

Example conversation:

> **Chatbot**: Hey User, I would like to learn how to code in JavaScript. Do you know any cool website where I could learn?

> **User**: I learned a lot from exercism.org, there's lots of great stuff there.

Implement the function `get_domains` which returns an array of website domains.

```jq
"I learned a lot from exercism.org and google.com" | get_domains
# => ["exercism.org", "google.com"]
```

## Greet the User

A polite Chatbot will speak to users by name.
When a user introduces themselves, our Chatbot will detect their name and respond with a friendly greeting.

Write the function `nice_to_meet_you`.

If the input string contains "My name is Someone.", capture the name and return the string "Nice to meet you, Someone.".

```jq
"My name is Jean-Luc" | nice_to_meet_you
# => "Nice to meet you, Jean-Luc"
```

## Very Simple CSV Parsing

Yielding to "creeping featuritis", we'll add a CSV parsing function to the Chatbot.

Implement the `parse_csv` function that takes a string and returns an array of the resulting fields.
The field separator should be "comma plus optional whitespace".

We won't worry about any of the edge cases with the CSV format (such as fields containing commas).

```jq
"first, second,third,   fourth" | parse_csv
# => ["first", "second", "third", "fourth"]
```
