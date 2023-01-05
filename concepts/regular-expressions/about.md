# About

**Regular expressions** are sequences of characters that specify a search pattern in text.

Learning regular expression syntax is beyond the scope of this topic.
We will focus on the expressions that `jq` provides to utilize regexes.

## Regex Flavour

Different tools implement regular expressions differently.
`jq` incorporates the [Oniguruma][oniguruma] library that is largely compatible with Perl v5.8 regexes.

Here is the [specific syntax used by `jq` version 1.6][onig-syntax].

## Regex Functions

Regular expressions in `jq` are not "first class" objects.
Their use is limited to [a set of filters][jq-regex-funcs].

### `test`


[oniguruma]: https://github.com/kkos/oniguruma
[onig-syntax]: https://github.com/kkos/oniguruma/blob/6fa38f4084b448592888ed9ee43c6e90a46b5f5c/doc/RE
[jq-regex-funcs]: https://stedolan.github.io/jq/manual/v1.6/#RegularexpressionsPCRE
