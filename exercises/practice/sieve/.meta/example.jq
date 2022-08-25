def mark_multiples(p; limit):
  if (.[p] == null) then .
  else
    reduce range(p * p; limit; p) as $m (.; .[$m] = null)
  end;

(.limit + 1) as $limit
| [range(0; $limit)]
| .[0] = null
| .[1] = null
| reduce range(2; $limit | sqrt) as $i (.; mark_multiples($i; $limit))
| map(select(. != null))
