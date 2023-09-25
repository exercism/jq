# Introduction

## Numbers

From [the manual][man-types]

> jq supports the same set of datatypes as JSON - numbers, strings, booleans, arrays, objects (which in JSON-speak are hashes with only string keys), and "null".

Let's focus on **numbers**.

### Numbers and numeric operators

All numbers, whether integers or otherwise, are IEEE754 double precision floating point numbers.
This limits us to 53 bits of precision.

The usual operators are available to use with numbers:

- arithmetic: `+`, `-`, `*`, `/`, `%`
- comparison: `==`, `!=`, `<`, `<=`, `>=`, `>`
- standard [math functions][man-math]

  For one-input functions, pipe the value into the function

  ```sh
  $ jq -n '(1 | atan) * 4'
  3.141592653589793
  ```

  For two-input functions, the functions will ignore input and expect the
  inputs as parameters (recall parameters are separated by semicolons)

  ```sh
  $ jq -n 'pow(2; 10)'
  1024
  ```

  Semi-colon is the separator for function arguments, not comma.

### Other `jq` expressions

To solve the exercise, you will need to know about conditional expressions.

#### Conditional Expressions

`jq` uses an [`if-then-else` expression][if-then-else] for **conditional expressions**.
As an _expression_, it is placed in a pipeline.

Then syntax is: `if CONDITION then TRUE_EXPR else FALSE_EXPR end`.
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

[man-types]: https://jqlang.github.io/jq/manual/v1.6/#TypesandValues
[man-math]: https://jqlang.github.io/jq/manual/v1.6/#Math
[if-then-else]: https://jqlang.github.io/jq/manual/v1.6/#if-then-else
