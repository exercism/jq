# Instructions

The day you waited so long for finally came; you are now the proud owner of a beautiful farm in the Alps.

You still do not like waking up early in the morning to feed your cows.
Because you are an excellent engineer, you build a food dispenser, the `FEED-M-ALL`.

The last thing required in order to finish your project is a piece of code that calculates the amount of fodder that each cow should get.
It is important that each cow receives the same amount: you need to avoid conflicts.
Cows are very sensitive.

Luckily, you don't need to work out all the formulas for calculating fodder amounts yourself.
You use some mysterious external library that you found on the internet.
It is supposed to result in the happiest cows.
The library exposes two functions:

- `fodder_amount` -- takes the number of cows as input, and outputs the total amount of fodder needed for the whole herd. For example:

  ```jq
  42 | fodder_amount
  # => 840
  ```

- `fattening_factor` -- outputs a factor that the fodder amount needs to be multiplied with. For example:

  ```jq
  fattening_factor
  # => 1.5
  ```

Both library functions may raise errors.

~~~~exercism/note
In `jq`, function arguments are _filters_ -- they act like what other languages call "callbacks".
Your functions will receive the library functions as arguments:

```jq
def divide_food(fodder_amount; fattening_factor):
  # call the library functions like any other filter
  ...
;
```

Don't forget: in an expression, the input will be passed to each filter:

```jq
def double: . * 2;
def triple: . * 3;
def addTwo(filter1; filter2): filter1 + filter2;

10 | addTwo(double; triple)
# => 50
```

Do not implement `fodder_amount` or `fattening_factor` yourself.
The tests provide mock implementations of the them.
~~~~

As you work on your code, you will improve the error handling to make it more robust and easier to debug later on when you use it in your daily farm life.

## 1. Divide the food evenly

First of all, you focus on writing the code that is needed to calculate the amount of fodder per cow.

Implement the `divide_food/2` function that takes the number of cows as input, and the two library functions as arguments.
_For this task, you can assume the number of cows is always greater than zero._
The function should output the amount of food per cow.

To make the calculation, you first need to retrieve the total amount of fodder for all the cows by calling `fodder_amount`.
Additionally, you need to retrieve the factor to multiply that amount with by calling `fattening_factor`.
With these two values and the number of cows, you can now calculate the amount of food per cow.
That is what `divide_food` should output.

If one of the library functions raises an error, the execution should stop and that error should be passed on, unchanged, to the caller of `divide_food`.

```jq
# For this example, we assume fodder_amount outputs 50
# and fattening_factor outputs 1.5.
5 | divide_food(fodder_amount; fattening_factor)
# => 15

# Now assume fodder_amount raises an error with value "something went wrong".
5 | divide_food(fodder_amount; fattening_factor)
# => error: "something went wrong"
```

## 2. Check the number of cows

While working on the first task above, you realized that the external library you use is not as high-quality as you thought it would be.
For example, it cannot properly handle invalid inputs.
You want to work around this limitation by adding a check for the input value in your own code.

Implement the `validate_input_and_divide_food/2` function with the same input and arguments as `divide_food`.

- If the number of cows is greater than 0, the function should divide the food as in task 1.
- If the number of cows is 0 or less, the function should raise an error with the value `"invalid number of cows"`.

```jq
5 | validate_input_and_divide_food(fodder_amount; fattening_factor)
# => 15

-2 | validate_input_and_divide_food(fodder_amount; fattening_factor)
# => error: "invalid number of cows"
```

## 3. Improve the error handling

Checking the number of cows before passing it along was a good move, but you are not quite happy with the unspecific error message.
You decide to do better by raising a _structured_ error.

Remember: in `jq`, the error value can be _any_ JSON value, not just a string.

Implement the `validate_number_of_cows/0` function that takes the number of cows as input.

- If the number of cows is less than 0, the function raises an error whose value is an object holding the number of cows and a custom message:

  ```json
  {"cows": <number of cows>, "message": "there are no negative cows"}
  ```

- If the number of cows is 0, the function raises an error whose value is:

  ```json
  {"cows": <number of cows>, "message": "no cows don't need food"}
  ```

- Otherwise, the function outputs the number of cows unchanged to indicate that the validation was successful.

```jq
-5 | try validate_number_of_cows catch .
# => {"cows": -5, "message": "there are no negative cows"}
```

## 4. Put it all together

The next morning, you wire the new validation function into the feeding code.

Implement the `feed_cows/2` function with the same input and arguments as `divide_food`.

- Validate the number of cows with `validate_number_of_cows`.
- If validation raises an error, catch it and raise a new error whose value is a string in the following format:

  ```txt
  {number of cows} cows are invalid: {message}
  ```

- If validation succeeds, divide the food as in task 1.
- Errors raised by the library functions should still be passed on, unchanged.

```jq
5 | feed_cows(fodder_amount; fattening_factor)
# => 15

-5 | try feed_cows(fodder_amount; fattening_factor) catch .
# => "-5 cows are invalid: there are no negative cows"
```

## 5. Work around the flaky scales

After a few days, you notice that the scales providing the `fattening_factor` are unreliable: every now and then, the function raises an error instead of producing a factor.
The cows still need to eat, so you decide that a failed weighing should not stop the feeding: if `fattening_factor` raises an error, silently fall back to a factor of `1`.

Implement the `divide_food_leniently/2` function with the same input and arguments as `divide_food`.

- If `fattening_factor` succeeds, use its value as in task 1.
- If `fattening_factor` raises an error, suppress the error and use `1` as the factor.
- Errors raised by `fodder_amount` should still be passed on, unchanged: an empty fodder silo is not something you want to ignore.

```jq
# Assuming fodder_amount outputs 50 and fattening_factor raises an error.
5 | divide_food_leniently(fodder_amount; fattening_factor)
# => 10
```
