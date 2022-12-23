# Instructions

In this exercise, you will write some code to help you prepare to buy a vehicle.

You have three tasks: determine if you will need to get a licence; choose between two vehicles; and estimate the acceptable price for a used vehicle.

## 1. Determine if you will need a drivers licence

Some kinds of vehicles require a drivers license to operate them.
Assume only the kinds `"car"` and `"truck"` require a license; everything else can be operated without a license.

Implement the `needs_license` function that takes the kind of vehicle and returns a boolean indicating whether you need a license for that kind of vehicle.

```jq
"car" | needs_license
# => true

"bike" | needs_license
# => false
```

## 2. Choose between two potential vehicles to buy

You have evaluated your options of available vehicles.
You managed to narrow it down to two options but you need help making the final decision.
Implement the function `choose_vehicle` that takes an array of two vehicles as input and returns a decision, which is the option that comes first in dictionary order.

```jq
["Wuling Hongguang", "Toyota Corolla"] | choose_vehicle
# =>  "Toyota Corolla is clearly the better choice."

["Volkswagen Beetle", "Volkswagen Golf"] | choose_vehicle
# =>  "Volkswagen Beetle is clearly the better choice."
```

## 3. Calculate an estimation for the price of a used vehicle

Now that you have made your decision, you want to make sure you get a fair price at the dealership.
Since you are interested in buying a used vehicle, the price depends on how old the vehicle is.
For a rough estimate, assume if the vehicle is less than 3 years old, it costs 80% of the original price it had when it was brand new.
If it is more than 10 years old, it costs 50%.
If the vehicle is at least 3 years old but not older than 10 years, it costs 70% of the original price.

Implement the `resell_price` function that applies this logic using `if`, `elif` and `else`.
It takes the an object holding the original price and the age of the vehicle and returns the estimated price in the dealership.

```jq
{"original_price: 1000, "age": 1} | resell_price
# => 800

{"original_price: 1000, "age": 5} | resell_price
# => 700

{"original_price: 1000, "age": 15} | resell_price
# => 500
```
