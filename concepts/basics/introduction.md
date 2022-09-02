# Introduction

jq works by passing the incoming JSON data through a _single expression_ (written as a _pipeline of filters_) to achieve the desired transformed data.

## Filters and Pipes

Filters are also known as Expressions.

A filter takes an input and produces an output.
Similar to a unix shell, join filters with a pipe `|` to connect the output of one filter to the input of another.

### The Identity Filter: `.`

This is the simplest filter.
It simply passes its input to its output.

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
    `range` is a function that outputs a stream of numbers

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

Within `{}`, add `key: value` pairs.
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

To treat the key as an _expression_, you must wrap it in parentheses
```sh
echo '[{"key":"question", "value":54}, {"key":"answer", "value":42}]' \
| jq '{(.[0].key): .[0].value, (.[1].key): .[1].value}'
```

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

We're _piping_ the output of the `.key2` expression as the input to `length` which unsurprisingly outputs the  number of elements in the array.


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
