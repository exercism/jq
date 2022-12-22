# Introduction

## Comparison

### Comparing Numbers

In `jq` numbers can be compared using the following relational and equality operators.

| Comparison             | Operator  |
| ---------------------- | --------- |
| Greater than           | `a > b`   |
| Greater than or equals | `a >= b`  |
| Less than              | `a < b`   |
| Less than or equals    | `a <= b`  |
| Equals                 | `a == b`  |
| Not equals             | `a != b`  |

The result of the comparison is always a boolean value, so either `true` or `false`.

```jq
1 < 3,      # => true
2 != 2,     # => false
1 == 1.0    # => true
```

All numbers are floating-points, so this is different syntax for the exact same value.

### Comparing Strings

The comparison operators above can also be used to compare strings.
In that case, a dictionary (lexicographical) order is applied.
The ordering is "by unicode codepoint value".

```jq
"Apple" > "Pear",   # => false
"a" < "above",      # => true
"a" == "A"          # => false
```

You need to be careful when you compare two variables that appear to contain numeric values but are of type string.
Due to the dictionary order, the result will not be the same as comparing values of type `Number`.

```jq
10 < 2,     # => false
"10" < "2"  # => true (because "1" comes before "2")
```

### "Strict" Equality

The `jq` `==` operator is like Javascript's `===` in the sense that things that "look" the same, but are of different types, are not equal.

```jq
"3" == 3    # => false
            # the value on the left has type string,
            # the value on the right has type number.
```

### Comparing Arrays

Two arrays are equal if all the corresponding elements are equal.

```jq
[1, 2, 3] == [1, 2, 3]      # => true
[1, 2, 3] == [1, 3, 2]      # => false, different order
[1, 2, 3] == [1, 2, "3"]    # => false, different types
```

### Comparing Objects

Two objects are equal if they have the same key:value pairs.

```jq
{name: "Joe", age: 42} == {age: 42, name: "Joe"}                # => true
{name: "Joe", age: 42} == {age: 42, name: "Jane"}               # => false
{name: "Joe", age: 42} == {age: "42", name: "Joe"}              # => false
{name: "Joe", age: 42} == {age: 42, name: "Joe", height: 175}   # => false
```

## Conditionals

### General Syntax

`jq`'s conditional expression is `if A then B else C end`.

If the expression `A` produces a "truthy" value, then the `if` filter outputs the result of passing the input to `B`.
Otherwise the `if` filter outputs the result of passing the input to `C`.

`if-then-else` is a filter like all jq builtins: it takes an input and produces an output.

```jq
42 | if . < 50 then "small" else "big" end      # => "small"
```
```jq
5 | if . % 2 == 0 then . / 2 else . * 4 end     # => 20
```

The `else` clause is **mandatory** in the current `jq` release (version 1.6).

### Nested If-Statements

Further conditions can be added with `elif`.

```jq
42 | if . < 33 then "small"
     elif . < 66 then "medium"
     else "big"
     end
# => "medium"
```

Use as many `elif` clauses as you need.

### Truthiness

The only "false" values in `jq` are: `false` and `null`.
Everything else is "true", even the number zero and the empty string/array/object.

### Complex Conditions

The boolean operators `and` and `or` can be used to build complex queries.

```jq
42 | if . < 33 or . > 66 then "big or small"
     else "medium"
     end
```

To negate, use `not`. This is a **filter** not an operator.

```jq
42 | if (. < 33 or . > 66 | not) then "medium"
     else "big or small"
     end
```

### Alternative Operator

The alternative operator allows you to specify a "default" value if an expression is false or null.

```jq
A // B

# This is identical to
if A then A else B end
```

To demonstrate

```jq
[3, 5, 18] | add / 2       # => 13
[]         | add / 2       # => error: null (null) and number (2) cannot be divided
[]         | add // 0 / 2  # => 0
```
