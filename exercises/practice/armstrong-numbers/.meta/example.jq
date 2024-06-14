def ipow(num; power):
  # could be implemented with a reduce, or even `pow|floor`
  def _ipow:
    if first == 0
      then last
      else [first - 1, last * num] | _ipow
    end
  ;
  [power, 1] | _ipow
;

def armstrong_sum:
  ((log10 | floor) + 1) as $wid
  | reduce range($wid) as $i ([0, .];
      . as [$sum, $num]
      | [ $sum + ipow($num % 10; $wid)
        , ($num / 10 | floor)
      ]
    )
  | first
;

.number | armstrong_sum == .
