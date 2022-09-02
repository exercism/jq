# Introduction

jq works by passing the incoming JSON data through a _single expression_ (written as a _pipeline of filters_) to achieve the desired transformed data.

## Filters and Pipes

Filters are also known as Expressions.

A filter takes an input and produces an output.
Similar to a unix shell, join filters with a pipe `|` to connect the output of one filter to the input of another.

### The Identity Filter: `.`

This is the simplest filter.
It simply passes its input to its output.
`jq` is quite handy to use just as a JSON pretty-printer.

```sh
$ echo '[1, 2, 3]' | jq '.'
[
  1,
  2,
  3
]
```

### Arrays

Array elements are accessed with brackets

```sh
$ echo '[10, 20, 30]' | jq '.[1]'
20
```

Array slices use a colon and return the subarray _from_ (inclusive) _to_ (exclusive)

```sh
$ echo '[0, 10, 20, 30, 40, 50]' | jq '.[1:4]'
[
  10,
  20,
  30
]
```

A filter can build an array by wrapping an expression in `[` and `]`

* with a known list of elements:

    ```sh
    jq -n '[1, 2, 3]'
    ```

* to collect a stream of elements: for example,
    [`range`][man-range] is a function that outputs a stream of numbers

    ```sh
    $ jq -n 'range(10; 70; 15)'
    10
    25
    40
    55
    ```

    Collect them in an array
    
    ```sh
    $ jq -c -n '[range(10; 70; 15)]'
    [10,25,40,55]
    ```

~~~~exercism/note
The comma is not just syntax that separates array elements.
Comma is an **operator** that joins streams.

For example `[1, 2, 3]` is a filter that uses the array constructor `[]`
to collect the result of the concatenation of the three expressions `1`, `2`
and `3`.
~~~~

### Objects

Similar to many programming languages, use dots to access object properties

```sh
$ echo '{"foo": {"bar": "qux"}}' | jq '.foo.bar'
"qux"
```

Brackets can be used for objects too, but then quotes are needed for string literals:

```sh
$ echo '{"foo": {"bar": "qux"}}' | jq '.["foo"]["bar"]'
"qux"
```

Construct an object with `{}` and `key: value` pairs.
Quotes are not required around keys that are "simple" strings.

```sh
jq -n '{question: 6 * 9, answer: 42}'
```
outputs
```none
{
  "question": 54,
  "answer": 42
}
```

To treat the key as an expression, you must wrap it in parentheses
```sh
echo '[["question", "answer"], [54, 42]]' \
| jq '{(.[0][0]): .[1][0], (.[0][1]): .[1][1]}'
```

~~~~exercism/note
It is quite common to want to extract a subset of keys from a large object:
for example to extract the `id` and `name` from

```json
{
    "id": 101,
    "name": "alpha widget",
    "specifications": {...}
}
```

We can write
```jq
{id: .id, name: .name}
```
This is so common, there is shorthand syntax for it:
```jq
{id, name}
```
~~~~

### Pipelines

For example, given "file.json" containing

```json
{
    "key1": "value1",
    "key2": [5, 15, 25]
}
```

Let's now calculate the length of the key2 array:

```sh
$ echo '{"key1": "value1", "key2": [5, 15, 25]}' | \
  jq -c '.key2 | length'
3
```

We're _piping_ the output of the `.key2` expression as the input to [`length`][man-length], which unsurprisingly outputs the  number of elements in the array.

~~~~exercism/caution
This is an aspect of `jq` that takes some getting used to --
most (but not all) functions act like _filters_ where you pass data to the filter's input, not as an argument.
~~~~

### Filters can ignore their input

For example:

```sh
jq '6 * 9' <<< '{"answer": 42}'
```

### Filters can output streams of data

A filter can output more than one value.
For example, the `.[]` filter outputs each element of an array as a separate value:

```sh
$ jq -n -c '[1, 2, 3]'
[1,2,3]

$ jq -n -c '[1, 2, 3] | .[]'
1
2
3
```

Piping such a filter into another will execute the 2nd filter **_for each value_**:

```sh
$ jq -n -c '[1, 2, 3] | .[] | . * 2'
2
4
6
```

This is like implicit iteration.
Once you grok this technique, you'll realize very powerful jq filters can be very concise.

## Types

From [the manual][man-types]

> jq supports the same set of datatypes as JSON - numbers, strings, booleans, arrays, objects (which in JSON-speak are hashes with only string keys), and "null".

We'll learn more about these in subsequent lessons.

## Whitespace

Whitespace is not significant in `jq`.
Use spaces/tabs/newlines as you see fit to format your code.
The author is unaware of any existing `jq` style guides.

## Immutable Values

Values in `jq` are _immutable_.
Filters that modify a value will output a new value.
This implies that `jq` does not have global variables --
you'll need to get used to passing state from one filter to another.

## "Truthiness"

The values `false` and `null` are considered false.  Any other value
(including the number zero and the empty string/array/object) is true.


[man-types]: https://stedolan.github.io/jq/manual/v1.6/#TypesandValues
[man-length]: https://stedolan.github.io/jq/manual/v1.6/#length
[man-range]: https://stedolan.github.io/jq/manual/v1.6/#range(upto),range(from;upto)range(from;upto;by)
