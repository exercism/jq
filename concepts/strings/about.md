# About

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

To find the number of characters: [`length`][length]
```sh
$ jq -cn --args  '$ARGS.positional[] | length' "Hello world!" "❄🌡🤧🤒🏥🕰😀"
12
7
```

To find the number of actual _bytes_: [`utf8bytelength`][utf8bytelength]
```sh
$ jq -cn --args  '$ARGS.positional[] | utf8bytelength' "Hello world!" "❄🌡🤧🤒🏥🕰😀"
12
27
```

## Substrings

The ["slice" notation][slice] can be used to extract substrings:

```jq
"abcdefghij"[3:6]   # => "def"
"abcdefghij"[3:]    # => "defghij"
"abcdefghij"[:-2]   # => "abcdefgh"
```

The first number is the (zero-based) start index (or 0 if absent).
The second number is the end index _plus one_ (or end of string if absent).
That is a bit confusing, but it corresponds with the `range/2` function where the 2 parameters are the range start (inclusive) and range end (exclusive).
## Concatenation

Use [`+`][+] to join strings:

```jq
"Hello" + " " + "world!"
# => "Hello world!"
```

Use [`add`][add] when given an array of strings:

```jq
["Hello", " ", "world!"] | add
# => "Hello world!"
```

## Split and Join

Splitting uses the [`split/1`][split/1] function or the [`/`][/] operator:

```jq
"Hello beautiful world!" | split(" ")   # => ["Hello", "beautiful", "world!"]
```
```jq
"Hello beautiful world!" / " "          # => ["Hello", "beautiful", "world!"]
```

The inverse of [`split/1`][split/1] is [`join/1`][join/1].

Converting a string into an array of characters is frequently needed.
There are two ways to do this:

1. split on an empty string

    ```jq
    "Hi friend 😀" / ""   # => ["H","i"," ","f","r","i","e","n","d"," ","😀"]
    ```

1. [`explode`][explode] into an array of _codepoints_

    ```jq
    "Hi friend 😀" | explode   # => [72,105,32,102,114,105,101,110,100,32,128512]
    ```

    [`implode`][implode] is the inverse of [`explode`][explode].

## Find the index of a substring

Use the [`index/1`][index/1] function: the index is zero-based.

```jq
"hello" | index("el")'   # => 1
```

If the substring is not in the string, the result is `null`
```jq
"hello" | index("elk")   # => null
```

Also useful: [`rindex/1`][index/1] and [`indices`][indices]

## String interpolation

Within a string, the sequence `\(expression)` will embed the _result_ of that expression [into the string][interpolate]:

```jq
"The current datetime is \(now | strflocaltime("%c"))"   # => "The current datetime is Wed Nov 16 17:06:33 2022"
```

## Case conversion

Use the [`ascii_downcase`][ascii_downcase] and [`ascii_upcase`][ascii_downcase] functions.

## Cast a string to a number

Use the [`tonumber`][tonumber] function.

This raises an error if the string cannot be cast to a number, so [`try-catch`][try-catch] may be needed.

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

Note that [JSON numbers][json-numbers] do not include hex or octal variations that some languages support.

## Other functions

Check [the manual][manual] for more details about these functions:

- repeat a string: `*`
- testing containment: `contains/1`, `inside/1`, `indices/1`, `index/1`, `rindex/1`, `startswith/1`, `endswith/1`
- trim: `lsrimstr/1`, `rtrimstr/1`
- formatting functions: `@text`, `@json`, `@html`, `@uri`, `@csv`, `@tsv`, `@sh`, `@base64`, `@base64d`

## Regular expressions

`jq` has rich support for regular expressions: this will be the topic of a later lesson.

[manual]: https://stedolan.github.io/jq/manual/v1.6/
[interpolate]: https://stedolan.github.io/jq/manual/v1.6/#Stringinterpolation-%5C(foo)
[length]: https://stedolan.github.io/jq/manual/v1.6/#length
[utf8bytelength]: https://stedolan.github.io/jq/manual/v1.6/#utf8bytelength
[+]: https://stedolan.github.io/jq/manual/v1.6/#Addition:+
[/]: https://stedolan.github.io/jq/manual/v1.6/#Multiplication,division,modulo:*,/,and%
[add]: https://stedolan.github.io/jq/manual/v1.6/#add
[split/1]: https://stedolan.github.io/jq/manual/v1.6/#Stringinterpolation-%5C(foo)
[join/1]: https://stedolan.github.io/jq/manual/v1.6/#join(str)
[explode]: https://stedolan.github.io/jq/manual/v1.6/#explode
[implode]: https://stedolan.github.io/jq/manual/v1.6/#implode
[ascii_downcase]: https://stedolan.github.io/jq/manual/v1.6/#ascii_downcase,ascii_upcase
[tonumber]: https://stedolan.github.io/jq/manual/v1.6/#tonumber
[try-catch]: https://stedolan.github.io/jq/manual/v1.6/#try-catch
[json-numbers]: https://www.json.org/json-en.html
[indices]: https://stedolan.github.io/jq/manual/v1.6/#indices(s)
[index/1]: https://stedolan.github.io/jq/manual/v1.6/#index(s),rindex(s)
[slice]: https://stedolan.github.io/jq/manual/v1.6/#Array/StringSlice:.[10:15]
