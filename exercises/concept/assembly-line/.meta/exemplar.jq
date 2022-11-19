def base_cars_per_hour:
  221
;

def success_rate:
  if   . == 10 then 0.77
  elif . ==  9 then 0.8
  elif . >=  5 then 0.9
  else 1
  end
;

def production_rate_per_hour:
  . * base_cars_per_hour * success_rate
;

def working_items_per_minute:
  production_rate_per_hour / 60 | trunc
;

.speed | (production_rate_per_hour, working_items_per_minute)
