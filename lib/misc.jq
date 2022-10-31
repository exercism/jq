# some miscellaneous filters that I wish jq had.


# You can do `$anObject | keys` but there's no `values`
# Expects an object as input.
# Outputs the object's values in the same order as the `keys`
def values: to_entries | map(.value);
# or,
# def values: . as $obj | keys | map($obj[.]);


# `to_entries` transforms an object into an array of
# {"key": "k1", "value": "v1"} objects.
# Let's output an array of ["k1", "v1"] arrays:
def pairs: to_entries | map([.key, .value]);
# or,
# def pairs: [keys , values] | transpose;
