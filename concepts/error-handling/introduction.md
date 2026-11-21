# Introduction

A `jq` program that runs into a problem while processing a value — indexing a number with a string, parsing invalid JSON text, calling a function with the wrong type of argument — raises a **runtime error**.
An uncaught runtime error makes `jq` print a message to _standard error_ and exit with status `5`.

## Raising errors: `error` and `error(message)`

- `error` raises an error whose value is the **input** value.
- `error(message)` raises an error whose value is the result of `message`.

The error value can be _any_ JSON value, not just a string.

```jq
42 | try error("invalid value: \(.)") catch .
# => "invalid value: 42"
```

## Catching errors: `try` and `catch`

Errors can be caught with `try EXP catch HANDLER`.
The first expression is executed; if it raises an error, the `HANDLER` expression is executed **with the error value as its input**.
The output of the handler is output as if it had been the output of the tried expression.

```jq
true | try .a catch "cannot index a \(type)"
# => "cannot index a boolean"

true | try error("some exception") catch .
# => "some exception"
```

The shorter form `try EXP` is equivalent to `try EXP catch empty`: the error is discarded and no output is produced.

```jq
[{}, true, {"a": 1}] | [.[] | try .a]
# => [null, 1]
```

## Suppressing errors: the `?` operator

The `?` operator, used as `EXP?`, is shorthand for `try EXP`.
It turns a failing expression into one that simply produces no output.

```jq
["1", "invalid", "3", 4] | [.[] | tonumber?]
# => [1, 3, 4]
```

It is often seen attached to the indexing operators: `.foo?` and `.[]?`.

## Halting the program: `halt_error`

`halt_error` stops the program, prints its input to _standard error_ as raw text, and exits with the given status, defaulting to `5`.
The related `halt` filter stops the program silently with exit status `0`.

```jq
"Error: something went wrong" | halt_error(1)
```
