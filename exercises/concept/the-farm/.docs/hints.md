# Hints

## 1. Divide the food evenly

- The function arguments are _filters_: call them like any other filter.
  Revisit the [functions concept][concept-functions] if you need a refresher.
- You need the number of cows more than once: save it in a [variable][concept-variables].
- In `jq`, an error automatically propagates to the caller until it is caught.
  For this task, no explicit error handling is needed at all.

## 2. Check the number of cows

- Use an [if-then-else expression][concept-conditionals] to check the number of cows.
- Use the [`error`][man-error] function to raise an error with a specific value.
  Make sure the error message matches the instructions exactly.
- Reuse the `divide_food` function from task 1.

## 3. Improve the error handling

- The error value can be any JSON value, including an [object][concept-objects].
- Make sure the object keys and the message strings match the instructions exactly.
- For a valid number of cows, output the input unchanged: the [identity filter][man-identity] does that.

## 4. Put it all together

- Catch the error with [`try-catch`][man-try-catch]: the input of the `catch` handler is the error value.
- Use [string interpolation][man-interpolation] to build the new error message from the structured error's fields.
- Raise the new error with [`error`][man-error]: a handler that _outputs_ the string would turn the error into normal output.
- Only catch the _validation_ error: library errors should keep propagating unchanged.
- `catch` binds loosely: wrap the `try-catch` expression in parentheses before piping its result to another filter.

## 5. Work around the flaky scales

- The [`?` operator][man-question-mark] suppresses an error by turning the failing expression into one that produces _no output_.
- Use the [alternative operator][man-alternative] `//` to provide a fallback value when an expression produces no output.
  Note that `//` also falls back on `false` and `null`; that is harmless here since the factor is a number.
- Apply the suppression _only_ to the `fattening_factor` call: an error from `fodder_amount` must keep propagating.

[concept-functions]: /tracks/jq/concepts/functions
[concept-variables]: /tracks/jq/concepts/variables
[concept-conditionals]: /tracks/jq/concepts/conditionals
[concept-objects]: /tracks/jq/concepts/objects
[man-error]: https://jqlang.org/manual/#error
[man-identity]: https://jqlang.org/manual/#identity
[man-try-catch]: https://jqlang.org/manual/#try-catch
[man-interpolation]: https://jqlang.org/manual/#string-interpolation
[man-question-mark]: https://jqlang.org/manual/#error-suppression-optional-operator
[man-alternative]: https://jqlang.org/manual/#alternative-operator
