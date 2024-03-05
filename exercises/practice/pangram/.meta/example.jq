def is_pangram:
  ("az" | explode) as [$a, $z]
  | [range($a; $z + 1)] as $alphabet
  | ascii_downcase
  | explode
  | map(select(IN($alphabet[])))
  | unique == $alphabet ;

.sentence | is_pangram
