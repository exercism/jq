# placeholder

## `jq` Tips

This exercise is about taking an input object and transforming it into a new object.
A couple of builtin functions that may help:

- [`to_entries`][x_entries]
  - this function takes an object as input
  - it outputs an _array_ -- each array element is an object `{"key": "K", "value": V}`
    - each `K` is a key from the input object
    - each `V` is `K`'s corresponding value.
- [`from_entries`][x_entries]
  - the inverse operation
  - takes an array of `{"key": K, "value": V}` objects and constructs an object

An example:

```sh
jq -n '
    {
        "username": "glennj",
        "tracks": ["bash", "awk", "jq"],
        "reputation": 123
    }
    | to_entries
'
```

outputs

```json
[
  {
    "key": "username",
    "value": "glennj"
  },
  {
    "key": "tracks",
    "value": ["bash", "awk", "jq"]
  },
  {
    "key": "reputation",
    "value": 123
  }
]
```

[x_entries]: https://jqlang.github.io/jq/manual/v1.6/#to_entries,from_entries,with_entries
