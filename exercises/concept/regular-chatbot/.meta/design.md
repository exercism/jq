# Design

## Learning objectives

- Learn about the flavour of jq Regular Expressions.
- How to create a regular expression in jq with strings only.
- How to use the regex related functions: test, match, capture, split, scan, sub, gsub
- How to pass flags to regex functions
- Understanding the different parts of the match result, including capture results
- Using the replace method alongside regular expressions

## Out of scope

This exercise is intended as an introduction to Regular Expressions in jq.
The main focus is understanding the different functions to **use** regexes.

Explaining how to write regular expressions themselves is out of scope for this concept.
While we could provide links to learn about regexes, we choose not to do this because Exercism assumes the student is already fluent in another language and most languages include some form of regular expressions.

## Concepts

- `regular-expressions`

## Prerequisites

- `strings`
- `arrays` as this is the result of match and other common functions.
- `functions` to understand calling regex functions with the target string as input and regex and options as arguments
