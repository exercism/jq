# Introduction

Recall that `jq` supports the same datatypes as JSON.
JSON describes **strings** as:

> A string is a sequence of zero or more Unicode characters, wrapped in double quotes, using backslash escapes.

## Escape sequences

Within a string, use the backslash character to embed "special" characters:

- `\"` a literal quotation mark,
- `\\` a literal backslash,
- whitespace characters `\n`, `\t`, `\r`, `\f`, `\b`
- unicode characters `\uAAAA` where `A` is a hex digit

## String length

To find the number of characters, use the `length` function.

```sh
$ jq -cn --args  '$ARGS.positional[] | length' "Hello world!" "❄🌡🤧🤒🏥🕰😀"
12
7
```

## Substrings

The **slice** notation can be used to extract substrings.
The syntax is `.[i:j]`.
The substring returned is of length `j - i`, returning characters from index `i` (inclusive) to index `j` (exclusive).
Either index can be negative, in which case it counts backwards from the end of the string.
Either index can be omitted, in which case it refers to the start or end of the string.
Indexes are zero-based.

```jq
"abcdefghij"[3:6]   # => "def"
"abcdefghij"[3:]    # => "defghij"
"abcdefghij"[:-2]   # => "abcdefgh"
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

Splitting uses the `split/1` function or the `/` operator:

```jq
"Hello beautiful world!" | split(" ")   # => ["Hello", "beautiful", "world!"]
```

```jq
"Hello beautiful world!" / " "          # => ["Hello", "beautiful", "world!"]
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

## Find the index of a substring

Use the `index/1` function; the index is zero-based.

```jq
"hello" | index("el")'   # => 1
```

If the substring is not in the string, the result is `null`

```jq
"hello" | index("elk")   # => null
```

## String interpolation

Within a string, the sequence `\(expression)` will embed the _result_ of that expression [into the string][interpolate]:

```jq
"The current datetime is \(now | strflocaltime("%c"))"   # => "The current datetime is Wed Nov 16 17:06:33 2022"
```

## Case conversion

Use the `ascii_downcase` and `ascii_upcase` functions.

## Regular expressions

`jq` has rich support for regular expressions: this will be the topic of a later lesson.

[interpolate]: https://jqlang.github.io/jq/manual/v1.7/#string-interpolation
