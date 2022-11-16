# Introduction

Recall that `jq` supports the same datatypes as JSON.
JSON describes strings as:

> A string is a sequence of zero or more Unicode characters, wrapped in double quotes, using backslash escapes.

## Escape sequences

Within a string, use the backslash character to embed "special" characters:

- `\"` a literal quotation mark,
- `\\` a literal backslash,
- whitespace characters `\n`, `\t`, `\r`, `\f`, `\b`
- unicode characters `\uAAAA` where `A` is a hex digit

## String length

To find the number of characters: `length`
```sh
$ jq -cn --args  '$ARGS.positional[] | length' "Hello world!" "❄🌡🤧🤒🏥🕰😀"
12
7
```

To find the number of actual _bytes_: `utf8bytelength`
```sh
$ jq -cn --args  '$ARGS.positional[] | utf8bytelength' "Hello world!" "❄🌡🤧🤒🏥🕰😀"
12
27
```

## Concatenation

Use `+` to join strings:

```jq
"Hello" + " " + "world!"
# => "Hello world!"
```

Use `add` when given an array of strings:

```jq
["Hello", " ", "world!"] | add
# => "Hello world!"
```

## Split and Join

Splitting uses the `split/1` function or `/`

```jq
"Hello world!" | split(" ")   # => ["Hello", "world!"]
```
```jq
"Hello world!" / " "          # => ["Hello", "world!"]
```

The inverse of `split/1` is `join/1`.

Converting a string into an array of characters is frequently needed.
There are two ways to do this:

1. split on an empty string

    ```jq
    "Hi friend 😀" / ""   # => ["H","i"," ","f","r","i","e","n","d"," ","😀"]
    ```

1. `explode` into an array of _codepoints_

    ```jq
    "Hi friend 😀" | explode   # => [72,105,32,102,114,105,101,110,100,32,128512]
    ```

    `implode` is the inverse of `explode`.

## String interpolation

Within a string, the sequence `\(expression)` will embed the _result_ of that expression:

```jq
"The current datetime is \(now | strflocaltime("%c"))"   # => "The current datetime is Wed Nov 16 17:06:33 2022"
```

## Cast a string to a number

Use the `tonumber` function.

This raises an error if the string cannot be cast to a number, so `try-catch` may be needed.

```jq
$ jq -cn --args '$ARGS.positional[] | [., tonumber]' 42 3.14 oops 1e6 0xbeef
["42",42]
["3.14",3.14]
jq: error (at <unknown>): Invalid numeric literal at EOF at line 1, column 4 (while parsing 'oops')

$ echo $?
5

$ jq -cn --args '$ARGS.positional[] | try [., tonumber] catch "not a number"' 42 3.14 oops 1e6 0xbeef
["42",42]
["3.14",3.14]
"not a number"
["1e6",1000000]
"not a number"
```

Note that JSON numbers do not include hex or octal variations that some languages support.

## Other functions

Check [the manual][manual] for more details about these functions:

- repeat a string: `*`
- testing containment: `contains/1`, `inside/1`, `indices/1`, `index/1`, `rindex/1`, `startswith/1`, `endswith/1`
- trim: `lsrimstr/1`, `rtrimstr/1`
- case conversion: `ascii_downcase`, `ascii_upcase`
- formatting functions: `@text`, `@json`, `@html`, `@uri`, `@csv`, `@tsv`, `@sh`, `@base64`, `@base64d`

[manual]: https://stedolan.github.io/jq/manual/v1.6/
