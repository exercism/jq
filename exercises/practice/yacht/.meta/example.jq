(reduce .dice[] as $d ([null,0,0,0,0,0]; .[$d] += 1)) as $count
| if   .category == "ones"   then 1 * $count[1]
  elif .category == "twos"   then 2 * $count[2]
  elif .category == "threes" then 3 * $count[3]
  elif .category == "fours"  then 4 * $count[4]
  elif .category == "fives"  then 5 * $count[5]
  elif .category == "sixes"  then 6 * $count[6]
  elif .category == "full house" and (2 | IN($count[])) and (3 | IN($count[])) then (.dice | add)
  elif .category == "four of a kind" then (
    $count
    | to_entries
    | map(select(.value >= 4) | .key * 4)
    | add // 0
  )
  elif .category == "little straight" and (.dice | sort) == [1,2,3,4,5] then 30
  elif .category == "big straight"    and (.dice | sort) == [2,3,4,5,6] then 30
  elif .category == "yacht" and (5 | IN($count[])) then 50
  elif .category == "choice" then (.dice | add)
  else 0
  end
