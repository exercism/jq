# Design

## Learning objectives

- Learn about the flavour of jq Regular Expressions.
- How to create a regular expression, in jq with strings only.
- How to use the most common regex related functions
    - test, match, capture, split, scan
- How to pass flags in both versions
- Understanding the different parts of the match result, incl. capture results
- Using the replace method alongside regular expressions
- Being aware of performance implications

## Out of scope

This exercise is intended as an introduction to Regular Expressions in jq.
The main focus resides in understanding the different functions to **use** regexes

Explaining how to write regular expressions themselves is out of scope for the concept here but we should link to some good resource a student could read to learn about them from scratch.
We don't do this as part of the concept because Exercism assumes the student is already fluent in another language and most languages include some form of regular expressions.

## Concepts

- `regular-expressions`

## Prerequisites

- `strings`
- `arrays` as this is the result of match and other common functions.
- `functions` to understand calling regex functions with the target string as input and regex and options as arguments
