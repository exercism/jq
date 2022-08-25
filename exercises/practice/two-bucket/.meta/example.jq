# Validate the input to check if the goal can be attained
def validate:
  # local helper function
  def gcd:
    if .[1] == 0
      then .[0]
      else [.[1], .[0] % .[1]] | gcd
    end;

  ([.bucketOne, .bucketTwo] | max) as $max |
  ([.bucketOne, .bucketTwo] | gcd) as $gcd |
  if (.goal > $max) or ($gcd != 1 and .goal % $gcd != 0)
    then ("goal is impossible to satisfy" | halt_error)
    else .
  end;


# Find the solution to the two bucket problem
#
# input:    2-element array: [firstBucket, secondBucket]
# argument: goal
# output:   result object {moves, goalBucket, otherBucket}
def solve($goal):

  # tail-call optimization only applies for 0-arity functions.
  # https://github.com/stedolan/jq/wiki/Advanced-Topics#recursion-and-tail-recursion-optimization
  # input to inner function is: [firstBucket, secondBucket, currentMove]
  def _solve:
    if .[0].amount == $goal
      then {moves: .[2], goalBucket: .[0].name, otherBucket: .[1].amount}
    elif .[1].amount == $goal
      then {moves: .[2], goalBucket: .[1].name, otherBucket: .[0].amount}
    else
      # if first is empty, fill it
      if .[0].amount == 0 then .[0].amount = .[0].size

      # optimization: if second is the right size, fill it
      elif .[1].size == $goal then .[1].amount = .[1].size

      # if second is full, empty it
      elif .[1].amount == .[1].size then .[1].amount = 0

      # pour from first into second
      else
        ([.[0].amount, .[1].size - .[1].amount] | min) as $qty |
        .[0].amount -= $qty |
        .[1].amount += $qty
      end
      # increment the current move and recurse
      | .[2] += 1 | _solve
    end;

  # initialize the current move onto the end of the input array
  . + [0] | _solve;


# "main"
#
validate |
.goal as $goal |
{ name: "one", amount: 0, size: .bucketOne } as $one |
{ name: "two", amount: 0, size: .bucketTwo } as $two |
if .startBucket == "one"
  then [$one, $two]
  else [$two, $one]
end |
solve($goal)
