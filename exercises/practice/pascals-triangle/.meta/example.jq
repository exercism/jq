[ # collect all the output from `foreach`
  foreach range(.count) as $n (
    [];
    # that range stops at 1; range is half-inclusive
    reduce range($n - 1; 0; -1) as $i (. + [1]; .[$i] += .[$i - 1])
  )
]
