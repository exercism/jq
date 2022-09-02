# Introduction

...


## Types

From [the manual][man-types]

> jq supports the same set of datatypes as JSON - numbers, strings, booleans, arrays, objects (which in JSON-speak are hashes with only string keys), and "null".

For now, let's just look at numbers.

### Numbers and numeric operators

All numbers, whether integers or otherwise, are represented as IEEE754
double precision floating point numbers. This limits us to 53 bits of
precision.

The usual operators are available to work with numbers

- arithmetic: `+`, `-`, `*`, `/`, `%`
- standard [math functions][man-math]

    For one-input functions, pipe the value into the function

    ```sh
    jq -n '(1 | atan) * 4'
    ```
    ```none
    3.141592653589793
    ```

    For two-input functions, the functions will ignore input and expect the
    inputs as parameters

    ```sh
    jq -n 'pow(2; 10)'
    ```
    ```none
    1024
    ```

    ~~~~exercism/caution
    Note the use of the semi-colon to separate arguments.
    This is a [common pitfall](https://github.com/stedolan/jq/wiki/How-to:-Avoid-Pitfalls#multi-arity-functions-and-commasemi-colon-confusability).

    `jq` uses commas to concatenate streams of data
    ```jq
    [range(1;4), range(11;14)] == [1, 2, 3, 11, 12, 13]
    ```

    Calling `pow(2, 10)` is calling the one-arity `pow/1` function
    passing the **expression** `2, 10`.

    Calling `pow(2; 10)` is calling the two-arity `pow/2` function
    passing the values `2` and `10`.
    ~~~~


[man-types]: https://stedolan.github.io/jq/manual/v1.6/#TypesandValues
[man-math]: https://stedolan.github.io/jq/manual/v1.6/#Math
