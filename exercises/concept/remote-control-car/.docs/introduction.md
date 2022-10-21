# Introduction

## Functions

You can define your own custom functions in `jq` to encapsulate whatever logic you need.
Functions act just like builtins: they take an input and emit zero, one or more outputs.

### Defining a function

You can define a `jq` function using the following syntax:

```jq
# no arguments
def funcname: expression;

# or with arguments
def funcname(args): expression;
```

- starts with `def` keyword,
- a colon before the function body,
- the body consists of a single expression,
- ends with a semicolon,
- like the rest of `jq` syntax, you can use arbitrary whitespace for readability.

### Where to put functions

Functions must be defined before they are used: this is an error:

```jq
def A: B(10);
def B(n): n + 1;
A
# => error: B/1 is not defined
```

This implies you have to place functions at the top of your jq code, prior to the "main" expression.

#### Nested functions

Functions can be nested:

```jq
def A:
    def B(n): n + 1;
    B(10)
    ;
A
# => 11
```

Here, the `B` function is only visible in the body of `A`.

### Scope

A function introduces a new scope for variables and nested functons.

### Arguments

Function arguments are separated by _semi-colons_ not commas.
For example, a function that takes a number, and then adds a number and multiplies by a number:

```jq
def add_mul(adder; multiplier): (. + adder) * multiplier;

10 | add_mul(5; 4)    # => 60
```

~~~~exercism/note
Semi-colons are needed because comma already has a purpose in `jq`: an operator that joins streams.

Using a comma instead of a semi-colon will attempt to call a _1-argument_ `add_mul` function, which doesn't exist:

```jq
10 | add_mul(5, 4)
# error: add_mul/1 is not defined
```
~~~~

#### Arguments are _expressions_

Function arguments are filters, not values.
In this sense, they act like what other languages describe as callbacks:

Using the `add_mul` function as an example:

```jq
10 | add_mul(. + 5; . - 2)    # => 200
```

What's happening here?

- the `adder` argument gets the _expression_ `. + 5`
  - when the function does `. + adder`, that becomes `. + . + 5`
  - that evaluates to 25 since `. == 10`
- similarly, the `multiplier argument is the expression `. - 2`
  - that evaluates to 8
  - then the result is `25 * 8 == 200`

#### Arguments as values

Sometimes you'll want to "materialize" an argument into a variable:

```jq
def my_func(arg):
    arg as $arg
    | other stuff ...
;
```

There's a shorhand for this:

```jq
def my_func($arg):
    other stuff ...
;
```

Take note that this is just "syntactic sugar": the name `arg` with no `$` is still in scope in the function.

### Arity

Functions have an "arity" -- the number of arguments they take.

Functions can use the same name with different arities.
The builtin [`range`][man-range] function demonstrates this: `range/1`, `range/2` and `range/3` all co-exist.

This can be useful for defining recursive functions that carry state via arguments.
For example `map` _could_ be implemented like:

```jq
def my_map($accumulator; func):
    if length == 0
        then $accumulator
        else first as $elem | .[1:] | my_map($accumulator + [$elem | func]; func)
    end
    ;

def my_map(func):
    my_map([]; func)
    ;

[1, 2, 3, 4] | my_map(. * 10)   # => [10, 20, 30, 40]
```

### Recursion

`jq` will perform tailcall optimization, but for 0-arity functions only.

### Modules

A `jq` module is a file containing only functions.
Modules are included into a jq program with the [`include`][man-include] or [`import`][man-import] commands.

[man-range]: https://stedolan.github.io/jq/manual/#range(upto),range(from;upto)range(from;upto;by)
[man-import]: https://stedolan.github.io/jq/manual/#importRelativePathStringasNAME[%3Cmetadata%3E];
[man-include]: https://stedolan.github.io/jq/manual/#includeRelativePathString[%3Cmetadata%3E];
