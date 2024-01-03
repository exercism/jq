# placeholder

## `jq` Tips

The [`if-then-else` expression][if] will be helpful in this exercise.
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

[if]: https://jqlang.github.io/jq/manual/v1.7/#if-then-else-end
