# We will get more in-depth about jq functions in a later lesson.
# For now, your job is to implement the logic of the tasks in the function
# bodies, so that they output the correct values.

# Task 1: calculate the production rate per hour
def production_rate_per_hour:
  # implement this function
  -1
;

# Task 2: calculate the number of working items produces per minute
def working_items_per_hour:
  # implement this function
  -2
;


# Input will be an object with a key "speed" whose value will be
# a number between 1 and 10 inclusive.
# The value is passed as input to the two functions.
#
.speed | (production_rate_per_hour, working_items_per_hour)
