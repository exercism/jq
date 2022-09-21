# placeholder

## `jq` Tips

The [`if-then-else` expression][if] will be helpful in this exercise.

One thing to note: the version of `jq` used in this track is **1.6**.
In this version, the `else` clause is **required**.

An example:

```jq
8, 12
| if . < 10
    then "\(.) is less than ten"
    else "\(.) is more than ten"
  end
```

outputs

```json
"8 is less than ten"
"12 is more than ten"
```

But

```jq
8, 12
| if . < 10 then "\(.) is less than ten" end
```

outputs

```none
jq: error: syntax error, unexpected end (Unix shell quoting issues?) at <top-level>, line 2:
| if . < 10 then "\(.) is less than ten" end
jq: error: Possibly unterminated 'if' statement at <top-level>, line 2:
| if . < 10 then "\(.) is less than ten" end
jq: 2 compile errors
```

[if]: https://stedolan.github.io/jq/manual/v1.6/#if-then-else
