# jq does not have bitwise operators

def count_eggs(count):
  if . == 0 then
    count
  else
    [(. / 2 | floor), . % 2] as [$next, $bit]
    | $next | count_eggs(count + $bit)
  end
;

.number | count_eggs(0)
