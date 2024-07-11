[ # collect all the output from `foreach`
  foreach range(.count) as $_ (
    [];
    # that range stops at 1; range is half-inclusive
    reduce range(length - 1; 0; -1) as $i (. + [1]; .[$i] += .[$i - 1])
  )
]
