# Functions in `jq`

You can define your own custom functions in `jq` to encapsulate whatever logic you need.
Functions act like builtins: functions will take an input and emit zero, one or more outputs.

## Defining a function

You can define a `jq` function using the following syntax:

```jq
def funcname: expression ;

# or

def funcname(args): expression ;
```

- starts with `def` keyword,
- colon after the `funcname(arglist)`,
- the function body consists of a single expression,
- ends with a semicolon.

Like the rest of `jq` syntax, you can use arbitrary whitespace for readability.

Recall that:

> jq works by passing the incoming JSON data through a _single expression_ (written as a _pipeline of filters_) to achieve the desired transformed data.

Functions are defined _outside_ of the single expression.
A `jq` program will look like

```jq
def func1: expr1 ;
def func2: expr2 ;
# ...

main | pipeline | goes | at | the | end
```

## Scope

A function introduces a new scope for variables and nested functons.

## Arguments

Functions have an "arity" -- the number of arguments they take.

Function arguments are separated by _semi-colons_ not commas.
For example, a function that takes a number, and then adds a number and multiplies by a number:

```jq
def add_mul(adder; multiplier): (. + adder) * multiplier;

10 | add_mul(5; 4)    # => 60
```

This is because the comma already has a purpose in `jq`: it's an operator that joins streams.

### Arguments are _expressions_

Function arguments are filters, not value.
In this sense, they act like what other languages describe as callbacks:

Using the `add_mul` function:

```jq
10 | add_mul(. + 5; . - 2)    # => 200
```

What's happening here?

* the `adder` argument gets the expression `. + 5`
    * when the function does `. + adder`, that becomes `. + . + 5`
    * when `. == 10` that evaluates to 25
* similarly, the `multiplier argument is the expression `. - 2`
    * when `. == 10` that evaluates to 8
    * then the result is `25 * 8 == 200`

### Arguments are expression, not values.

Sometimes you'll want to "materialize" the argument into a variable:

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

- ref https://glennj.github.io/jq/notes 

## Arity

Functions can use the same name with different arities.
The builtin [range][man-range] function demonstrates this.

This can be useful for defining recursive functions that carry state via arguments:

TODO:  add example here

While I'm talking about recursion, `jq` will perform tailcall optimization, but for 0-arity functions only.


[man-range]: https://stedolan.github.io/jq/manual/#range(upto),range(from;upto)range(from;upto;by)
