def toRoman:
  def _helper:
    if .n == 0 then .r
    else
      if   .n >= 1000 then (.n -= 1000 | .r +=  "M")
      elif .n >=  900 then (.n -=  900 | .r += "CM")
      elif .n >=  500 then (.n -=  500 | .r +=  "D")
      elif .n >=  400 then (.n -=  400 | .r += "CD")
      elif .n >=  100 then (.n -=  100 | .r +=  "C")
      elif .n >=   90 then (.n -=   90 | .r += "XC")
      elif .n >=   50 then (.n -=   50 | .r +=  "L")
      elif .n >=   40 then (.n -=   40 | .r += "XL")
      elif .n >=   10 then (.n -=   10 | .r +=  "X")
      elif .n >=    9 then (.n -=    9 | .r += "IX")
      elif .n >=    5 then (.n -=    5 | .r +=  "V")
      elif .n >=    4 then (.n -=    4 | .r += "IV")
      else                 (.n -=    1 | .r +=  "I")
      end
      | _helper
    end
  ;
  {n: ., r: ""} | _helper
;

.number | toRoman
