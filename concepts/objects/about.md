# About

To use terminology from other languages, a JSON object is a "hash" or "map" or "dictionary".

JSON defines an object as:

> An object is an unordered set of **name**/**value** pairs.
> An object begins with `{`left brace and ends with `}`right brace.
> Each _name_ is followed by `:`colon and the _name/value_ pairs are separated by `,`comma.

Further, the _name_ must be a string.
Another word for _name_ is _key_.

The _value_ can be of _any_ JSON type.
Different keys in the object can have values of different type, like this example.

```json
{
  "name": "Jane",
  "age": 42,
  "pets": ["cat", "fish"],
  "address": {"street": "123 Main St", "city": "Springfield"}
}
```

Note that there _must not_ be a comma following the _last_ key-value pair.

## Creating objects

Use braces to collect the name/value pairs.
Even though the names must be strings, if the names are "identifier-like"
(composed of alphanumeric characters and underscore, and not started with a digit)
they do not need to be quoted.

```jq
{name: "Jane", age: 42}
```

If the name is the result of an expression, the expression _must_ be in parentheses.
```sh
$ echo "Jane" | jq -Rc '{.: 42}'
jq: error: syntax error, unexpected '.' (Unix shell quoting issues?) at <top-level>, line 1:
{.: 42}
jq: error: May need parentheses around object key expression at <top-level>, line 1:
{.: 42}
jq: 2 compile errors

$ echo "Jane" | jq -Rc '{(.): 42}'
{"Jane":42}
```

## Indexing

Values are retrieved from an object with dot notation:

```jq
{name: "Jane", age: 42} | .age    # => 42
```

If you cannot refer to the key as an identifier, use bracket notation:

```jq
"name" as $key | {name: "Jane", age: 42} | .$key    # => error
"name" as $key | {name: "Jane", age: 42} | .[$key]  # => "Jane"
```

## Adding key-value pairs

Use the `=` assignment operator, with an index expression on the left-hand side

```jq
{name: "Jane", age: 42} | .sport = "tennis"
# => {
#      "name": "Jane",
#      "age": 42,
#      "sport": "tennis"
#    }
```

## Indexing nested values

Given an object that contains array or object values, we can "chain" index expressions together

```jq
{
  "name": "Jane",
  "age": 42,
  "pets": ["cat", "fish"],
  "address": {"street": "123 Main St", "city": "Springfield"}
} as $example
|
  $example.pets[1],       # => "fish"
  $example.address.city   # => "Springfield"
```

## Removing a key

Use the `del/1` function.
It returns the updated object.

```jq
{name: "Jane", age: 42} | del(.age)   # => {name: "Jane"}
```

## Membership

1. Test if the object `has` a key.

   ```jq
   {name: "Jane", age: 42} as $example
   |
     ($example | has("name")),    # => true
     ($example | has("sport"))    # => false 
   ```

1. Test if a key is `in` an object

   ```jq
   {name: "Jane", age: 42} as $example
   |
     ("name"  | in($example)),    # => true
     ("sport" | in($example))     # => false 
   ```

## List all the keys

Use the `keys` function to output a list of all the keys. 

Not that `keys` will _sort_ the keys.
To retrieve the keys in the original order, use `keys_unsorted`.

## Iterating

To iterate over an object, we must first convert it to an array of key-value objects.
The `to_entries` function does that.

```jq
{name: "Jane", age: 42} | to_entries'
```
outputs
```json
[
  {
    "key": "name",
    "value": "Jane"
  },
  {
    "key": "age",
    "value": 42
  }
]
```

At this point, we can use the array iteration functions, like `map`.

The `from_entries` function is the inverse: convert an array of key-value objects into an object

```jq
[
  {"key":"name","value":"Jane"},
  {"key":"age","value":42}
] | from_entries
```
outputs
```json
{"name": "Jane", "age": 42}
```

To apply a filter to _each_ key-value pair in an object, use the `with_entries(filter)` function.

For example, with an object that maps a name to an age, to swap the keys and values:

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
