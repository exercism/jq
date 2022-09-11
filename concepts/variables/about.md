# Introduction

Recall that a `jq` program is a _pipeline of expressions_.
Variable assigmnent follows this rule.
A variable assignment is an expression that looks like:

```jq
... | expr as $varname | ...
```

## The filter outputs the input

The input is used in the `expr` to produce a value that is bound to the variable name.
The output of the variable assignment is the same as the input to the expression.

Example, showing `.` after the assignment is the same as the initial input:

```sh
$ jq -c -n '42 | (. * 2) as $double | [., $double]'
[42,84]
```

## Variable scope

The scope of the variable is "lexical" -- the variable will be in scope for the rest of the pipeline.
Variables defined in functions (we'll get to functions later) are "local" to the function.

## Variable names

The variable must begin with `$`.
The rest of the variable names is an "identifier": starts with a letter or underscore followed by letters, numbers or underscores.

## Destructuring assignment

From the manual:

> Multiple variables may be declared using a single as expression by providing a pattern that matches the structure of the input (this is known as "destructuring").

Examples:

```jq
[1, 2, 3] as [$a, $b, $c]

{"foo": "bar", "len": [10, 20]} as {foo: $f, len: [$h, $w]}
```

Matching the variable name to the object key offers a shortcut:

```jq
{"x": 4, "y": 7} as {$x, $y}
{"foo": "bar", "len": [10, 20]} as {$foo, $len}
```

~~~~exercism/note
The same shortcut works for object **construction**

```jq
4 as $x | 7 as $y | {$x, $y}    # => {"x":4, "y": 7}
```
~~~~

## Constants

As shows in the above example, variables are handy for storing constants.
It's better to give constants a name rather than have "magic numbers" show up in the code.

## Often variables are not needed

It is often more readable to omit variables.

Consider calculating the average of a list of numbers

```jq
[2, 4, 8, 7]
| add as $sum
| length as $len
| $sum / $len
```

compared to
```jq
[2, 4, 8, 7] | add / length
```

This highlights one of the most powerful aspects of `jq`: the input to a filter is provided to _every_ sub-expression.

