"ABCDEFGHIJKLMNOPQRSTUVWXYZ" as $alphabet
| .letter as $letter
| ($alphabet | index($letter) + 1) as $len
| ($alphabet / "")[0:$len] as $letters

# given the list of letter to use, make the rows for the top half
| ("." * $len) as $blank
| [
    foreach range($len) as $i (null; null;
      ($blank[0:$i] + $letters[$i] + $blank[$i+1:$len]) as $right_half
      | ($right_half[1:$len] | explode | reverse | implode) as $left_half
      | $left_half + $right_half
    )
  ]

# then add the bottom half
| . + (.[0:length - 1] | reverse)
| join("\n")
