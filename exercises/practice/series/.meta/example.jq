def assert(cond; errmsg):
  if (cond | not) then errmsg | halt_error(1)
  else .
  end;

# Check all edge cases/validations.
assert(.sliceLength != 0; "slice length cannot be zero") |
assert(.sliceLength > 0; "slice length cannot be negative") |
assert(.series | length > 0; "series cannot be empty") |
assert(.sliceLength <= (.series | length); "slice length cannot be greater than series length") |
# Actual solution.
.series as $series |
.sliceLength as $length |
[range(($series | length) - $length + 1) | $series[.:. + $length]]
