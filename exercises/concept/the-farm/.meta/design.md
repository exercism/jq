# Design

## Learning objectives

- Know that a runtime error aborts the program unless it is handled.
- Know how to raise an error with `error` and `error(message)`.
- Know that the error value can be _any_ JSON value, including structured data.
- Know that an error automatically propagates to the caller until it is caught.
- Know how to catch an error with `try-catch`, and that the error value becomes the input of the catch handler.
- Know how to transform an error inside a catch handler and raise a new error.
- Know how to suppress an error with the `?` operator and provide a fallback value with the `//` operator.

## Out of scope

- `halt` and `halt_error`.
- Compile-time errors.
- Debugging helpers (`debug`, `stderr`, `$__loc__`).

## Concepts

- `error-handling`

## Prerequisites

- `functions` -- in particular, that function arguments are filters that act like callbacks.
- `conditionals` -- to validate the input.
