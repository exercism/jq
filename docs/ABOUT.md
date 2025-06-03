# About

`jq` is a tool for parsing and transforming JSON data.
`jq` is like `sed` for JSON data -- you can use it to slice and filter and map and transform structured data with the same ease that `sed`, `awk`, `grep` and friends let you play with text.

`jq` is a dynamically-typed functional programming language.
All values are immutable.

`jq` programs are composed of pipelines of "filters": each filter takes a single item as input, acts on it, and outputs zero or more transformed elements.
A "filter" can also be called an "expression".

The output(s) of an expression can be passed to another using the `|` operator.
`expressionA | expressionB` applies `expressionA` to some input, then `expressionB` executes repeatedly for each of the outputs of `expressionA`.

The input to an expression can be referred to explicitly as `.`.
An expression that adds `1` to its input reads like so: `. + 1` (or `1 + .`).

## `jq` (the program) versus `jq` (the language)

`jq` is a program you can install as a package on a variety of operating systems,
or build it from source (it's coded in C).
It has several useful [command-line options][cli-options], and is quite fast.

The `jq` program also implements a _language_ to enable arbitrarily complex manipulations of the input data.

This Exercism track will focus on the language.
You will see usage of the `jq` program in the tests.

## Versions

This Exercism track will focus on the original implementation of `jq`, whose home is [https://jqlang.github.io/jq/][jq].
Other implementations, such as [`gojq`][gojq], may have different syntax to what is documented here.

## JSON

From [json.org][json]:

> JSON (JavaScript Object Notation) is a lightweight data-interchange format.
> It is easy for humans to read and write.
> It is easy for machines to parse and generate.
> It is based on a subset of the JavaScript Programming Language Standard ECMA-262 3rd Edition - December 1999.
> JSON is a text format that is completely language independent but uses conventions that are familiar to programmers of the C-family of languages, including C, C++, C#, Java, JavaScript, Perl, Python, and many others.
> These properties make JSON an ideal data-interchange language.

This track is about `jq` not JSON.
We will assume you are familiar with [JSON syntax and data types][wiki-json].

## Further reading

- [`jq` home][jq]
- [`jq` wiki][jq-wiki]
- [Stack Overflow jq info page][so]

[jq]: https://jqlang.github.io/jq/
[jq-wiki]: https://github.com/jqlang/jq/wiki
[so]: https://stackoverflow.com/tags/jq/info
[json]: https://www.json.org
[wiki-json]: https://en.wikipedia.org/wiki/JSON#Syntax
[cli-options]: https://jqlang.github.io/jq/manual/#invoking-jq
[gojq]: https://github.com/itchyny/gojq#gojq
