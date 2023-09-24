# Instructions

In this exercise you're going to implement some recursive functions.

## 1. Implement a function to add the numbers in an array

We'll re-implement the builtin `add` filter to practice recursion.
The _base case_ is that an empty array has a sum of **zero**.

Implement it yourself with a recursive function; don't use the builtin `add`.

```jq
[5, 4, 6, 10] | array_add     # => 25
```

## 2. Reverse an array

We'll re-implement the builtin `reverse` filter.
The _base case_ is that an empty array reversed is an empty array.

Implement it yourself with a recursive function; don't use the builtin `reverse`.

```sh
[5, 4, 6, 10] | array_reverse   # => [10, 6, 4, 5]
```

## 3. Map an array

We'll re-implement the builtin `map` filter.
The function takes a filter as a parameter, run that filter for each element of the input array, and return the outputs in a new array.
The _base case_ is that an empty array maps to an empty array.

Implement it yourself with a recursive function; don't use the builtin `map`.

```sh
[5, 4, 6, 10] | array_map(. + 10)   # => [15, 14, 16, 20]
```
