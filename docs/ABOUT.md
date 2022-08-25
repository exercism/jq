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

## JSON

From [json.org][json]:

> JSON (JavaScript Object Notation) is a lightweight data-interchange format.
> It is easy for humans to read and write.
> It is easy for machines to parse and generate.
> It is based on a subset of the JavaScript Programming Language Standard ECMA-262 3rd Edition - December 1999.
> JSON is a text format that is completely language independent but uses conventions that are familiar to programmers of the C-family of languages, including C, C++, C#, Java, JavaScript, Perl, Python, and many others.
> These properties make JSON an ideal data-interchange language.

## Further reading

- [`jq` home][jq]
- [`jq` wiki][jq-wiki]
- [AWK on Wikipedia][wiki]
- [Stack Overflow jq info page][so]



[jq]: https://stedolan.github.io/jq/
[jq-wiki]: https://github.com/stedolan/jq/wiki
[wiki]: https://en.wikipedia.org/wiki/AWK
[so]: https://stackoverflow.com/tags/jq/info
[json]: https://www.json.org
