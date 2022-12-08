# Introduction

## Arrays

JSON defines an array as:

> An array is an ordered collection of values.
> An array begins with `[` left bracket and ends with `]` right bracket.
> Values are separated by `,` comma.

Arrays can contain zero or more of _any kind_ of JSON values.
Array elements do not need to be all the same type.

### Creating arrays

Use brackets to collect elements into an array
```jq
[1, 2, 3]
```

The elements of a _stream_ can be captured into an array by enclosing it in brackets.
```jq
range(5)     # => a stream of 5 numbers
[range(5)]   # => the array [0, 1, 2, 3, 4]
```

### Size

The `length` function returns the number of elements in an array.

### Indexing and slicing

Array indexing is zero-based.

Retrieve an element from an array with a bracket expression:
`.[2]` gets the third element.

Negative indexes count backwards from the end of the array:
`.[-1]` gets the last element; `.[-2]` is the second last.

A "slice" is a sub-sequence of the array.
.`[10:15]` returns 5 elements starting from index 10; the end index is _not included_.

There are some convenience functions:

- `first` gets the first element,
- `last` gets the last element,
- `nth(n)` gets the element at index `n`

### Iterating

`jq` provides many functions to cover common iteration functionality:

- `map(expr)` returns a new array where the `expr` is applied to each element in turn

  ```jq
  [1, 2, 3] | map(. * 10)    # => [10, 20, 30]

- `select(expr)` is a function that applies the `expr` to a _single value_:
  if the result of the expression is true, then the value is returned;
  if the result is false, _nothing_ is returned -- not `null`, actually nothing.

  To apply that to an array, combine it with `map`

  ```jq
  [range(10)] | map(select(. % 2 == 0))    # => [0, 2, 4, 6, 8]
  ```
  
  Alternately, apply `select` to a _stream_ and collect the results

  ```jq
  [range(10) | select(. % 2 == 0)]    # => [0, 2, 4, 6, 8]
  ```

- `any(condition)` and `all(condition)` return a boolean value whether any/all of the elements in the array pass the condition.

  ```jq
  [1, 2, 3, 4] | any(. > 4)    # false
  [1, 2, 3, 4] | any(. >= 4)   # true

  [1, 2, 3, 4] | all(. >= 4)   # false
  [1, 2, 3, 4] | all(. <= 4)   # true
  ```
