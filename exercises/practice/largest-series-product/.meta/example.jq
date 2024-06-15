def assert(cond; msg):
  if cond then . else (msg | halt_error) end
;

def product:
  reduce .[] as $n (1; . * $n)
;

  assert(.span >= 0;                  "span must not be negative")
| assert(.span <= (.digits | length); "span must be smaller than string length")
| assert(.digits | test("^\\d*$");    "digits input must only contain digits")

| .span as $span
| (.digits / "" | map(tonumber)) as $digits
| [
    range(($digits | length) - $span + 1)
    | $digits[.:. + $span]
    | product
  ]
| max
