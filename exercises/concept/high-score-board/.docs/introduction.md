# Introduction

## Objects

A JSON object is, to use terminology from other languages, a "hash", "map", or "dictionary".

JSON defines an object as:

> An object is an unordered set of **name**/**value** pairs.
> An object begins with `{`left brace and ends with `}`right brace.
> Each _name_ is followed by `:`colon and the _name/value_ pairs are separated by `,`comma.

The _name_ **must be a string**.
Another word for _name_ is _key_.

The _value_ can be of any JSON type.
Different _values_ in the same object can be different type, like this example.

```json
{
  "name": "Jane",
  "age": 42,
  "pets": ["cat", "fish"],
  "address": {"street": "123 Main St", "city": "Springfield"}
}
```

Note that there **must not** be a comma following the _last_ key-value pair.

### Creating objects

Use braces to collect the name/value pairs.
Even though the names must be strings, they do not need to be quoted if the names are "identifier-like" (composed of alphanumeric characters and underscore, and not started with a digit).

```jq
{name: "Jane", age: 42}
```

It is valid to use keys that are not "identifier-like".
Just quote them.

```jq
{"first name": "Jane", "last name": "Lopez", age: 42}
```

If the name is the result of an expression, the expression **must** be in parentheses.

```sh
$ echo "Jane" | jq -Rc '{.: 42}'
# verbose error message ...

$ echo "Jane" | jq -Rc '{(.): 42}'
{"Jane":42}
```

### Indexing

Values are retrieved from an object with _dot notation_.

```jq
{name: "Jane", age: 42} | .age    # => 42
```

If you cannot refer to the key as an identifier, use _bracket notation_.

```jq
"name" as $key | {name: "Jane", age: 42} | .$key    # => error
"name" as $key | {name: "Jane", age: 42} | .[$key]  # => "Jane"
```

### Adding or changing key-value pairs

To add a new key-value pair to an array, or to update the value of an existing key, use the `=` assignment operator, with an index expression on the left-hand side.

```jq
{name: "Jane", age: 42} | .sport = "tennis" | .age = 21
# => {
#      "name": "Jane",
#      "age": 21,
#      "sport": "tennis"
#    }
```

The `+` operator will _merge_ objects.

```jq
{Richard: 54} + {Jane: 42}
# => {
#      "Richard": 54,
#      "Jane": 42
#    }
```

### Removing a key

Use the `del` function to remove a key.
It returns the updated object.

```jq
{name: "Jane", age: 42} | del(.age)   # => {name: "Jane"}
```

The parameter to `del` is a _path expression_ that resolves to a key in the object.
That is to say, it is an **index** expression.
It is not sufficient to just give a string.

```jq
{name: "Jane", age: 42} | del(name)        # error: name/0 is not defined
{name: "Jane", age: 42} | del("name")      # error: Invalid path expression with result "name"
{name: "Jane", age: 42} | del(.name)       # OK
{name: "Jane", age: 42} | del(.["name"])   # OK
```

### Membership

- To test if the object has a key, use the `has` function.

  ```jq
  {name: "Jane", age: 42} as $example
  |
    ($example | has("name")),    # => true
    ($example | has("sport"))    # => false
  ```

- Test if a key is in an object with `in`.

  ```jq
  {name: "Jane", age: 42} as $example
  |
    ("name"  | in($example)),    # => true
    ("sport" | in($example))     # => false
  ```

### List all the keys

Use the `keys` function to output a list of all the keys.

```jq
{name: "Jane", age: 42} | keys   # => ["age", "name"]
```

Note that `keys` will _sort_ the keys.
To retrieve the keys in the original order, use `keys_unsorted`.

There is no equivalent function to list all the _values_.
However the `.[]` filter outputs the object values as a _stream_, and that stream can be captured with the `[...]` array constructor.

```jq
[{first: "Jane", last: "Lopez", status: "awesome!"} | .[]]
# => ["Jane", "Lopez", "awesome!"]
```

### Iterating

- The `map_values(filter)` function applies the filter to each _value_ in the object.

  ```jq
  {first: "Jane", last: "Lopez", status: "awesome!"}
  | map_values(ascii_upcase)
  # => {"first": "JANE", "last": "LOPEZ", "status": "AWESOME!"}
  ```

- To iterate over an object, we must first convert it to an array of key-value objects.
  The `to_entries` function does that.

  ```jq
  {name: "Jane", age: 42} | to_entries'
  # => [
  #      {
  #        "key": "name",
  #        "value": "Jane"
  #      },
  #      {
  #        "key": "age",
  #        "value": 42
  #      }
  #    ]
  ```

  At this point, we can use array iteration functions, like `map`.

- The `from_entries` function is the inverse: convert an array of key-value objects into an object.

  ```jq
  [
    {"key":"name", "value":"Jane"},
    {"key":"age", "value":42}
  ] | from_entries                  # =>{"name": "Jane", "age": 42}
  ```

- To apply a filter to _each_ key-value pair in an object, use the `with_entries(filter)` function.

  For example, given an object that maps a name to an age, the keys and values can be swapped as follows.

  ```jq
  {"Jane": 42, "Richard": 54}
  | with_entries({key: (.value | tostring), value: .key})
  ```
  outputs
  ```json
  {
    "42": "Jane",
    "54": "Richard"
  }
  ```

  `with_entries(filter)` is the same as
  ```jq
  to_entries | map(filter) | from_entries
  ```
