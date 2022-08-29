# Task 1
.exercise,

# Task 2
.cases[0].description,
# or:
# (.cases | first | .description),

# Task 3
.cases[-1].input.name,
# or:
# (.cases | last | .input | .name),

# Task 4
(.cases | length),

# Task 5
(.cases | all(.property == "twoFer"))
# or:
# (.cases | map(.property == "twoFer") | all)
