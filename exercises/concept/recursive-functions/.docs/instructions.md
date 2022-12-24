# Instructions

In this exercise you're going to implement a couple of recursive functions.

## 1. Implement a function to add the numbers in an array

We'll re-implement the builtin `add` filter to practice recursion.
The _base case_ is that an empty function has a sum of **zero**.

Implement it yourself with a recursive function; don't use the builtin `add`.

```jq
[5, 4, 6, 10] | array_sum     # => 25
```

## 2. Reverse an array

TODO instructions

Implement it yourself with a recursive function; don't use the builtin `reverse`.

```sh
[5, 4, 6, 10] | array_reverse   # => [10, 6, 4, 5]
```

## 3. Map an array

TODO instructions

Implement it yourself with a recursive function; don't use the builtin `map`.

```sh
[5, 4, 6, 10] | array_map(. + 10)   # => [15, 14, 16, 20]
```
