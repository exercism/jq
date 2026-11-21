# About

## Errors in `jq`

`jq` reports two broad categories of errors:

1. **Compile-time errors** — the program itself is invalid: syntax errors, references to undefined functions or variables, and so on.
   `jq` refuses to run the program at all.

   ```sh
   $ jq -n '1 + $foo + 2'
   jq: error: $foo is not defined at <top-level>, line 1, column 5:
       1 + $foo + 2
           ^^^^
   jq: 1 compile error
   ```

2. **Runtime errors** — the program is valid, but something goes wrong while it processes a value: indexing a number with a string, parsing invalid JSON text with `fromjson`, calling a function with arguments of the wrong type, and so on.

   ```sh
   $ echo '42' | jq '.foo'
   jq: error (at <stdin>:1): Cannot index number with "foo"
   ```

This concept is about **runtime errors**: how to raise them, how to catch them, and how to stop them.

An uncaught runtime error causes `jq` to print a message to _standard error_ and exit with status `5`.

## Raising errors: `error` and `error(message)`

The [`error`][man-error] filter raises an error.

- `error` raises an error whose value is the **input** value.
- `error(message)` raises an error whose value is the result of `message`.

```jq
"bad input" | try error catch .
# => "bad input"

42 | try error("invalid value: \(.)") catch .
# => "invalid value: 42"
```

~~~~exercism/note
The error value can be _any_ JSON value, not just a string.
Raising structured errors lets a `catch` handler make decisions based on the error's contents.

```jq
try error({kind: "range", msg: "age must be non-negative"})
catch (if type == "object" then "\(.kind) error: \(.msg)" else "unexpected: \(.)" end)
# => "range error: age must be non-negative"
```
~~~~

If a non-string error value is not caught, `jq` prints it as JSON, flagged with `(not a string)`.

```sh
$ jq -n 'error({code: 42, msg: "boom"})'
jq: error (at <unknown>) (not a string): {"code":42,"msg":"boom"}
```

## Catching errors: `try` and `catch`

Errors can be caught with [`try EXP catch HANDLER`][man-try-catch].
The first expression is executed; if it raises an error, the `HANDLER` expression is executed **with the error value as its input**.
The output of the handler is output as if it had been the output of the tried expression.

```jq
true | try .a catch "cannot index a \(type)"
# => "cannot index a boolean"

[{}, true, {"a": 1}] | [.[] | try .a]
# => [null, 1]

true | try error("some exception") catch .
# => "some exception"
```

The shorter form `try EXP` is equivalent to `try EXP catch empty`: the error is discarded and no output is produced.

```jq
[{}, true, {"a": 1}] | [.[] | try .a]
# => [null, 1]
```

~~~~exercism/note
An error **aborts the rest of the stream** inside the `try`.
Values already produced are kept, but nothing after the error is evaluated.

```jq
jq -n 'try (1, error("x"), 3) catch "caught: \(.)"'
# outputs:
# 1
# "caught: x"
# (3 is never produced)
```
~~~~

A handler can raise a new error, or re-raise the original one with a plain `error` — since the error value is the handler's input, this propagates it unchanged.

```jq
try repeat(f) catch
  if . == "break" then empty else error end
```

## Suppressing errors: the `?` operator

The [`?` operator][man-question-mark], used as `EXP?`, is shorthand for `try EXP`.
It turns a failing expression into one that simply produces no output.

```jq
["1", "invalid", "3", 4] | [.[] | tonumber?]
# => [1, 3, 4]

true | [.a?]
# => []
```

It is often seen attached to the indexing operators:

- `.foo?` is `.["foo"]?`
- `.[]?` iterates only if the input is an array or object, and is empty otherwise

~~~~exercism/caution
`?` suppresses **every** error, including ones you did not anticipate.
`user.name?` silently produces nothing when `user` is not an object, which can hide data problems or typos in your program.
Prefer `try ... catch` when you need to know _that_ something failed, or validate the input explicitly.
~~~~

## The alternative operator `//` does not suppress errors

Programmers sometimes expect `a // b` to produce `b` when `a` fails — that was true in very old versions of `jq`, but not since `jq` 1.6.
The `//` operator only substitutes `b` when `a` produces no value, `false`, or `null`; errors in `a` still propagate.

```sh
$ jq -n '(error("x")) // 42'
jq: error (at <unknown>): x
```

Use `try a catch b` if you want a fallback for errors.

## The destructuring alternative operator `?//`

The [`?//` operator][man-question-mark-slash-slash] combines destructuring with error handling: it tries each binding pattern in turn until one succeeds, and variables bound by the failing alternatives are set to `null`.

```jq
# input:
#   [
#     {"a": 1, "b": 2, "c": {"d": 3, "e": 4}},
#     {"a": 5, "b": 6, "c": [{"d": 7, "e": 8}]}
#   ]

.[] as {$a, $b, c: {$d, $e}} ?// {$a, $b, c: [{$d, $e}]}
| {$a, $b, $d, $e}

# outputs:
# {"a": 1, "b": 2, "d": 3, "e": 4}    # first element: c is an object, first pattern matched
# {"a": 5, "b": 6, "d": 7, "e": 8}    # second element: c is an array, second pattern matched
```

Here the first pattern expects `c` to be an _object_ with `d` and `e` keys, while the second expects `c` to be an _array_ containing such an object.
The first input element binds with the first pattern; the second element fails that pattern, so the second pattern is tried instead.

This lets a single program destructure inputs that may take one of several shapes, without writing explicit `if type == ...` chains.

## Halting the program: `halt` and `halt_error`

Sometimes the right response to an error is to stop processing altogether.

- [`halt`][man-halt] stops the `jq` program immediately with no further output; the exit status is `0`.
- [`halt_error`][man-halt-error] stops the program, prints its **input** to _standard error_ as raw text (no decoration, not even a newline), and exits with the given status, defaulting to `5`.

```sh
$ echo '"Error: something went wrong"' | jq 'halt_error(1)'
Error: something went wrong    # printed on stderr, exit status 1
```

Note that these filters halt the program immediately, even if more inputs remain to be read.

### Exit statuses

For reference, `jq` uses these exit statuses:

| Status | Meaning                                          |
| :----: | ------------------------------------------------ |
| `0`    | success                                          |
| `2`    | usage error (bad command-line options)           |
| `3`    | compile error                                    |
| `5`    | runtime error (or `halt_error` with no argument) |

With the `--exit-status` / `-e` option, the status instead reflects the last output value: `0` for `true` or numbers, `1` for `false` or `null`, `4` for no output.

## Debugging helpers

When tracking down where an error comes from, these filters help:

- [`debug`][man-debug] passes its input through unchanged, but prints `["DEBUG:", <input>]` to standard error.
  `debug(msgs)` prints `msgs` as debug messages too.
- [`stderr`][man-stderr] prints its input, raw and compact, to standard error.
- [`input_line_number`][man-input-line-number] outputs the line number of the input currently being filtered — invaluable when a file contains many JSON texts and one of them is bad.
- [`$__loc__`][man-loc] outputs an object with `file` and `line` keys describing where in the program it occurs, which can be embedded in error messages.

```jq
def checked_div($d):
  if $d == 0
  then error("\($__loc__): division by zero")
  else . / $d end;

try (10 | checked_div(0)) catch .
# => "{\"file\":\"<top-level>\",\"line\":3}: division by zero"
```

[man-error]: https://jqlang.org/manual/v1.8/#error
[man-try-catch]: https://jqlang.org/manual/v1.8/#try-catch
[man-question-mark]: https://jqlang.org/manual/v1.8/#error-suppression-optional-operator
[man-question-mark-slash-slash]: https://jqlang.org/manual/v1.8/#destructuring-alternative-operator
[man-halt]: https://jqlang.org/manual/v1.8/#halt
[man-halt-error]: https://jqlang.org/manual/v1.8/#halt_error
[man-debug]: https://jqlang.org/manual/v1.8/#debug
[man-stderr]: https://jqlang.org/manual/v1.8/#stderr
[man-input-line-number]: https://jqlang.org/manual/v1.8/#input_line_number
[man-loc]: https://jqlang.org/manual/v1.8/#$__loc__

