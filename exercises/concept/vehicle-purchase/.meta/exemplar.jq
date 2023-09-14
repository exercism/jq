# Determines whether or not you need a license to operate a certain kind of vehicle.
#
# input: {string} kind of vehicle
# output: {boolean} whether a license is required

def needs_license:
  . == "car" or . == "truck";

# Helps choosing between two options by recommending the one that
# comes first in dictionary order.
#
# input: list of strings
# output: {string} a sentence of advice which option to choose

def choose_vehicle:
  . as [$a, $b]
  | (if $a < $b then $a else $b end) as $choice
  | "\($choice) is clearly the better choice.";

# Calculates an estimate for the price of a used vehicle in the dealership
# based on the original price and the age of the vehicle.
#
# @param {number} originalPrice
# @param {number} age
# @returns {number} expected resell price in the dealership

def resell_price:
  ( if .age < 3 then 80
    elif .age > 10 then 50
    else 70
    end
  ) as $percentage
  | .original_price * $percentage / 100;
