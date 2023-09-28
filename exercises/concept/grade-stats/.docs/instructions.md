# Instructions

You are a teacher.
At the end of the year, you have generated a numeric grade for each of your students.
Now you need to translate that to a letter grade and count how many students have achieved each letter grade

## 1. Translate a numeric grade to a letter grade

The `letter_grade` function will take a numeric grade as input, and it will output the letter.
Use these ranges:

| Letter |      Grade |
| :----: | ---------: |
|   A    | 90% - 100% |
|   B    |  80% - 89% |
|   C    |  70% - 79% |
|   D    |  60% - 69% |
|   F    |   0% - 59% |

Example:

```jq
75 | letter_grade   # => "C"
```

## 2. Count the number of students for each letter grade

The function `count_letter_grades` will take an object mapping student names to their grades.
The output will be an object mapping each letter grade to the number of students with that grade.

Example:

```jq
{"Joe": 78, "Jane": 93, "Richard": 72} | count_letter_grades
# => {"A": 1, "B": 0, "C": 2, "D": 0, "F": 0}
```

There are a few different ways to solve this.
Use the `reduce` filter for practice.
