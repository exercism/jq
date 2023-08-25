def parse_digit:
  if . == " "
    then empty
    else tonumber
  end;

def double_digit:
    2 * .
  | if . > 9 then . - 9 else . end;

  .value
| split("")
| try map( parse_digit ) catch []
| reverse
| [ .[ range(0; length; 2) ]                ] as $at_odd_indices
| [ .[ range(1; length; 2) ] | double_digit ] as $at_even_indices
| $at_odd_indices + $at_even_indices
| length > 1 and add % 10 == 0
