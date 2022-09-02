# Task 1
.name,

# Task 2
(.ingredients | length),

# Task 3
(.ingredients[] | select(.item == "sugar") | .amount.quantity),

# Task 4
(
  (.ingredients + ."optional ingredients")
  | map(select(.substitute) | {(.item): .substitute})
  | add
)
#
# alternately:
#     reduce 
#         ( (.ingredients + ."optional ingredients")[] | select(has("substitute")) ) as $i
#         ({}; . + {($i.item): $i.substitute})
