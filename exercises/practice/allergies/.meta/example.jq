def shift_right($n; $pos):
  $n / ($pos | exp2) | floor
;
def bit_at($n; $pos):
  shift_right($n; $pos) % 2
;


# input: an object with a "score" key
def allergiesList:
  .score as $score
  | [ "eggs", "peanuts", "shellfish", "strawberries",
      "tomatoes", "chocolate", "pollen", "cats" ]
  | to_entries
  | map(select(bit_at($score; .key) == 1) | .value)
;


# input: an object with an "item" key and a "score" key 
def allergicTo:
  allergiesList as $as
  | .item | IN($as[])
;


if   .property == "list"       then (.input | allergiesList)
elif .property == "allergicTo" then (.input | allergicTo)
else empty
end
