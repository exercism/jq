# Introduction

## Recursion

**Recursive functions** are functions that call themselves.

A _recursive function_ needs to have at least one _base case_ and at least one _recursive case_.

A **base case** returns a value without calling the function again.
A **recursive case** calls the function again, modifying the input so that it will at some point match the base case.

Here is an example that counts the elements of an array.

```jq
def count:
  if length == 0 then
    0                       # base case
  else
    1 + (.[1:] | count)     # recursive case
  end;

([] | count),           # => 0
([11, 22, 33] | count)  # => 3
```

A _recursive function_ can have many _base cases_ and/or many _recursive cases_.
For example [the Fibonacci sequence][wiki-fibonacci] is a recursive sequence with two _base cases_.

```jq
def fibonacci:
  if . == 0 then
    0
  elif . == 1 then
    1
  else
    (. - 1 | fibonacci) + (. - 2 | fibonacci)
  end;

10 | fibonacci          # => 55
```

Counting the number of occurrences of some given value `x` in a list has two _recursive cases_.

```jq
def count_occurrences(x):
  if length == 0 then
    0
  elif first == x then
    1 + (.[1:] | count_occurrences(x))
  else
    (.[1:] | count_occurrences(x))
  end;

[11, 22, 33, 22, 44] | count_occurrences(22)    # => 2
```

In practice, iterating over lists and other enumerable data structures is most often done using builtin functions,
such as `map` and `reduce`, or by [using streams][map-implementation] like `[.[] | select(...)]`.
Under the hood, some builtins are [implemented using recursion][range-implementation].

[map-implementation]: https://github.com/stedolan/jq/blob/jq-1.6/src/builtin.jq#L3
[range-implementation]: https://github.com/stedolan/jq/blob/jq-1.6/src/builtin.jq#L157
[wiki-fibonacci]: https://en.wikipedia.org/wiki/Fibonacci_number
