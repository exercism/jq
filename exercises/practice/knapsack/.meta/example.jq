# Algorithm taken from Wikipedia:
# https://en.wikipedia.org/wiki/Knapsack_problem
# 
# Define m[i,w] to be the maximum value that can be attained
# with weight less than or equal to w using items up to i
# (first i items).
# 
# We can define m[i,w] recursively as follows:
# 
#     m[0,w] = 0
#     m[i,w] = m[i−1,w] if w_{i} > w (the new item is more than the current weight limit)
#     m[i,w] = max (m[i−1,w], m[i−1, w − w_{i}] + v_{i}) if w_{i} ⩽ w

. as {$maximumWeight, $items}
| reduce range(1; $maximumWeight + 1) as $w ([[]]; .[0][$w] = 0)
| reduce range(1; ($items | length) + 1) as $i (.;
    $items[$i - 1] as $item 
    | reduce range(1; $maximumWeight + 1) as $w (.;
        .[$i][$w] = if $item.weight > $w
                      then .[$i - 1][$w]
                      else ([
                        .[$i - 1][$w],
                        .[$i - 1][$w - $item.weight] + $item.value
                      ] | max)
                    end
    )
)
| .[-1][-1]
