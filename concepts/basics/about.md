# About

jq works by passing the incoming JSON data through a _single expression_ (written as a _pipeline of filters_) to achieve the desired transformed data.

## A quick introduction to `jq` command-line options

The `jq` language is implemented by the `jq` _program_.
This program provides several handy command-line options to control how the input is consumed and how the output is presented.

In the examples below you'll encounter:

- `-n` or `--null-input`

  Normally the `jq` program is given a file to read, or you send data to its input.
  The `--null-input` option allows you to generate JSON data without any inputs.

- `-c` or `--compact-output`

  `jq` pretty-prints its output by default.
  It it extremely useful for humans to view the data when it's nicely formatted.
  However that's not necessary for machines: the `--compact-output` option removes the formatting whitespace to minimize the size of the resulting JSON.

See [the manual][man-cli] for details about all the options.

## Filters and Pipes

Filters are also known as Expressions.

A filter takes an input and produces an output.
Like the way you work in a unix shell, you can join filters with a pipe `|` to connect the output of one filter to the input of another.

### The Identity Filter: `.`

This is the simplest filter.
It simply passes its input to its output.
For example, `jq` pretty-prints by default, so passing JSON the `.` filter gives nicely formatted output for free!

```sh
$ echo '[1, 2, 3]' | jq '.'
[
  1,
  2,
  3
]
```

### Arrays

Array elements are accessed with brackets, and are zero-indexed.

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

- with a known list of elements:

  ```sh
  jq -n '[1, 2, 3]'
  ```

- to collect a stream of elements: for example,
  [`range`][man-range] is a function that outputs a stream of numbers

  ```sh
  $ jq -n 'range(10; 70; 15)'
  10
  25
  40
  55
  ```

  Using `[]` collects the results of the expression into an array

  ```sh
  $ jq -c -n '[range(10; 70; 15)]'
  [10,25,40,55]
  ```

#### Comma is an operator

The comma is not just syntax that separates array elements.
Comma is an **operator** that joins streams.

For example `[1, 2, 3]` is a filter that uses the array constructor `[]` to collect the result of joining the three expressions `1`, `2` and `3`.

Did you notice the semi-colons in `range(10; 70; 15)` above?
Because commas have a specific purpose in the `jq` language, functions that take multiple arguments use semi-colons to separate the arguments.

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

You can construct an object with `{}` and `key: value` pairs.
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

<!-- prettier-ignore -->
~~~~exercism/note
It is quite common to want to extract a subset of keys from a large object.
For example, to extract `id` and `name` from

```json
{
    "id": 101,
    "name": "alpha widget",
    "specifications": {...}
}
```

We could write
```jq
{id: .id, name: .name}
```
But this is so common, there is shorthand syntax for it:
```jq
{id, name}
```
~~~~

<!-- prettier-ignore-end -->

### Pipelines

For example, given "file.json" containing

```json
{
  "key1": "value1",
  "key2": [5, 15, 25]
}
```

Let's calculate the length of the key2 array:

```sh
$ jq '.key2 | length' file.json
3
```

We're _piping_ the output of the `.key2` expression as the input to [`length`][man-length], which unsurprisingly outputs the number of elements in the array.

<!-- prettier-ignore -->
~~~~exercism/caution
This is an aspect of `jq` that takes some getting used to --
most (but not all) functions act like _filters_ where you pass data to the filter's input, not as an argument.
~~~~

<!-- prettier-ignore-end -->

### Filters can ignore their input

In this example, the input JSON data is ignored and has no impact on the output:

```sh
$ echo '{"answer": 42}' | jq '6 * 9'
54
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
Once you understand this technique, you'll realize very powerful jq filters can be very concise.

## Types

From [the manual][man-types]

> jq supports the same set of datatypes as JSON - numbers, strings, booleans, arrays, objects (which in JSON-speak are hashes with only string keys), and "null".

You'll learn more about these in subsequent exercises.

## Whitespace

Whitespace is not significant in `jq`.
Use spaces/tabs/newlines as you see fit to format your code.
We are unaware of any existing `jq` style guides.

## Immutable Values

Values in `jq` are _immutable_.
Filters that modify a value will output a new value.
This implies that `jq` does not have global variables --
you'll need to get used to passing state from one filter to another.

## "Truthiness"

The values `false` and `null` are considered false. Any other value
(including the number zero and the empty string/array/object) is true.

## Functions and Operators

Without going into great depth (functions will be a topic for another exercise!), here are some useful builtin functions:

- [`length`][man-length]

  Given an array as input, output the number of elements in the array.

  ```sh
  $ jq -n '[10, 20, 30, 40] | length'
  4
  ```

- [`+`][man-plus]

  This operator does different things depending on the type of its operands:
  it adds numbers,
  it concatenates strings,
  it appends arrays,
  it merges objects.

  ```sh
  $ jq -c -n '
      3 + 4,
      "foo" + "bar",
      ["a", "b"] + ["c"],
      {"m": 10} + {"n": 20}
  '
  7
  "foobar"
  ["a","b","c"]
  {"m":10,"n":20}
  ```

  [`add`][man-add] is a function that takes an array and returns an item with all the elements added together using the rules of `+`.
  `[1, 2, 3] | add` outputs `6`.

- [`map`][man-map]

  Given an array as input and a filter as an argument, output an array where the filter is applied to each element

  ```sh
  $ jq -c -n '[10, 20, 30, 40] | map(. / 5)'
  [2,4,6,8]
  ```

- [`select`][man-select]

  Given _some_ input and a filter as an argument:

  - if the filter applied to the argument results in a **true** value, output the input unchanged
  - otherwise, output _nothing_ (not the `null` value, truly no output)

  For example, given some numbers, select the ones divisible by 3

  ```sh
  $ jq -n 'range(10) | select(. % 3 == 0)'
  0
  3
  6
  9
  ```

  Recall that `range` outputs a _stream_ of numbers.
  `select` will be invoked once per each number.
  Only the numbers "passing" the expression are output.

  You often need to select elements of an array.
  There are a couple of ways to do this.

  With the input `["Anne", "Bob", "Cathy", "Dave"]`, select the names having length 4.

  - use `map` and `select` together

    ```jq
    map(select(length == 4))
    ```

  - explode the array into elements, `select` on that stream, and collect the results

    ```jq
    [ .[] | select(length == 4) ]
    ```

## Comments

Comments start with a `#` character and continue to the end of the line.

[man-cli]: https://stedolan.github.io/jq/manual/v1.6/#Invokingjq
[man-types]: https://stedolan.github.io/jq/manual/v1.6/#TypesandValues
[man-length]: https://stedolan.github.io/jq/manual/v1.6/#length
[man-range]: https://stedolan.github.io/jq/manual/v1.6/#range(upto),range(from;upto)range(from;upto;by)
[man-map]: https://stedolan.github.io/jq/manual/v1.6/#map(x),map_values(x)
[man-plus]: https://stedolan.github.io/jq/manual/v1.6/#Addition:+
[man-add]: https://stedolan.github.io/jq/manual/v1.6/#add
[man-select]: https://stedolan.github.io/jq/manual/v1.6/#select(boolean_expression)
