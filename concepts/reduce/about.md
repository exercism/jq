# About

Reducing is a process to iterate over a data structure, applying a function at each step that updates some form of accumulated result.
In `jq`, this process is implemented in the [`reduce`][jq-man-reduce] filter.
In other languages, it might be called "fold", "fold-left", "inject", or "aggregate".

The `jq` `reduce` expression looks like this.
```jq
reduce STREAM as $var (INITIAL_STATE; REDUCING_EXPRESSION)
```

- STREAM is a _stream_ of items, each stored in the $var variable in turn.
- INITIAL\_STATE is the starting value of the accumulated result.
- The REDUCING\_EXPRESSION is the where the current value from the stream is "folded" into the accumulated result.
  - In the context of this expression, `.` is the current value of the accumulator.
  - The output of the expression is stored into the accumulator for use in the next iteration.
  - After the last iteration, the accumulated result is the output of `reduce`.

Let's look at an example -- adding up the numbers in an array.
Of course the `add` filter is designed just for this purpose, but we'll see how to implement it.

If we use `[10, 20, 30, 40]` as the input, and taking zero as the initial state, what we're going to is:

| \# | state | element | reducer | result |
| --- | --- | --- | --- | --- |
| 1 |  0 | 10 |  0 + 10 |  10 |
| 2 | 10 | 20 | 10 + 20 |  30 |
| 3 | 30 | 30 | 30 + 30 |  60 |
| 4 | 60 | 40 | 60 + 40 | 100 |

Expressed with the `reduce` filter we have

```jq
[10, 20, 30, 40] | reduce .[] as $n (0; . + $n)     # => 100
```

~~~~exercism/note
The `add` builtin [is actually implemented with `reduce`][jq-code-add], but uses "null" as the initial state (any data type can be added to null).

```jq
def add: reduce .[] as $x (null; . + $x);
```
~~~~

## Some things to keep in mind

- In the reducing expression, `.` is the accumulator.
  If the input is some object that you need to refer to inside the reducing function, you'll want to store it in a variable.

  ```jq
  # a contrived example
  {"apple": 10, "banana": 16, "carrot": 4} as $obj
  | reduce (keys | .[]) as $key (0; . + $obj[$key])     # => 30
  ```

- The accumulator can be any type of data.
  For example you may want to reverse an array.

  ```jq
  ["alpha", "beta", "gamma", "delta"]
  | reduce .[] as $elem ([]; [$elem] + .)       # ["delta", "gamma", "beta", "alpha"]
  ```

- `reduce` uses a _stream_ of data to iterate over.
  You'll need to utilize the `.[]` iterator filter.

[jq-man-reduce]: https://stedolan.github.io/jq/manual/v1.6/#Reduce
[jq-code-add]: https://github.com/stedolan/jq/blob/master/src/builtin.jq#L11
