def divide_food(fodder_amount; fattening_factor):
  . as $cows
  | fodder_amount * fattening_factor / $cows
;

def validate_input_and_divide_food(fodder_amount; fattening_factor):
  if . > 0
    then divide_food(fodder_amount; fattening_factor)
    else error("invalid number of cows")
  end
;

def validate_number_of_cows:
  if . < 0
    then error({cows: ., message: "there are no negative cows"})
    elif . == 0
    then error({cows: ., message: "no cows don't need food"})
    else .
  end
;

def feed_cows(fodder_amount; fattening_factor):
  (try validate_number_of_cows
   catch error("\(.cows) cows are invalid: \(.message)"))
  | divide_food(fodder_amount; fattening_factor)
;

def divide_food_leniently(fodder_amount; fattening_factor):
  . as $cows
  | fodder_amount * (fattening_factor? // 1) / $cows
;
