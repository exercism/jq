# Task 1
.name,

# Task 2
(.ingredients | length),

# Task 3
.ingredients[] | select(.item == "sugar") | .amount.quantity,

# Task 4

# Task 5
(.cases | all(.property == "twoFer"))
# or:
# (.cases | map(.property == "twoFer") | all)
