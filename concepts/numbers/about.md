# About

## Numbers and numeric operators

All numbers, whether integers or otherwise, are represented as C `double` type: IEEE754 double precision floating point numbers.
This limits us to 53 bits of precision.

The usual operators are available to work with numbers

- arithmetic: `+`, `-`, `*`, `/`, `%`
- comparison: `==`, `!=`, `<`, `<=`, `>=`, `>`
- standard [math functions][man-math]

  For one-input functions, pipe the value into the function

  ```sh
  $ jq -n '(1 | atan) * 4'
  3.141592653589793
  ```

  For two-input functions, the functions will ignore input and expect the
  inputs as parameters

  ```sh
  $ jq -n 'pow(2; 10)'
  1024
  ```

<!-- prettier-ignore -->
~~~~exercism/caution
What does it mean to say "This limits us to 53 bits of precision"?

A demonstration:

```sh
$ jq -n 'pow(2;52) as $n | [$n, $n+1]'
[
  4503599627370496,
  4503599627370497
]
```

That looks good. What if we bump the exponent?

```sh
$ jq -n 'pow(2;53) as $n | [$n, $n+1]'
[
  9007199254740992,
  9007199254740992
]
```

Those numbers should not be equal. 
That's the loss of precision.
This means that `jq` is not capable of handling arbitrarily large numbers.
~~~~

<!-- prettier-ignore-end -->

## Conditional Expressions

`jq` uses an [`if-then-else` expression][if-then-else] for conditional expressions.
As an _expression_, it is placed in a pipeline.

Then syntax is: `if A then B else C end`.
The `else` clause is required in jq v1.6.

```jq
42 | if . < 33 then "small" else "larger" end
# => "larger"
```

Additional conditions use `elif`

```jq
42 | if . < 33 then "small"
     elif . < 67 then "medium"
     else "large"
     end
# => "medium"
```

[man-types]: https://stedolan.github.io/jq/manual/v1.6/#TypesandValues
[man-math]: https://stedolan.github.io/jq/manual/v1.6/#Math
[if-then-else]: https://stedolan.github.io/jq/manual/v1.6/#if-then-else
