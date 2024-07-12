def shift_right($n; $pos):
  $n / ($pos | exp2) | floor
;

def bit_set($n; $pos):
  shift_right($n; $pos) % 2 == 1
;

.number as $n
| ["wink", "double blink", "close your eyes", "jump"] as $actions
| $actions
| to_entries
| map(select(bit_set($n; .key)) | .value)
| if bit_set($n; $actions | length) then reverse end
