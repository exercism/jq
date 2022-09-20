# Instructions

In this exercise you're going to write some code to help you make a brilliant lasagna from your favorite cookbook.

You have four tasks, all related to the time spent cooking the lasagna.

## 1. Define the expected oven time in minutes

Define a constant named `$expected_minutes_in_oven`.
According to the cookbook, the expected oven time in minutes is 40:

```sh
$ jq -n -f lasagna.jq
{
  "expected_minutes_in_oven": 40,
  ...
```

## 2. Calculate the remaining oven time in minutes

This value takes the actual minutes the lasagna has been in the oven as input and returns how many minutes the lasagna still has to remain in the oven, based on the expected oven time in minutes from the previous task.

```sh
$ echo '{"actual_minutes_in_oven": 18}' | jq -f lasagna.jq
{
  "expected_minutes_in_oven": 40,
  "remaining_minutes_in_oven": 22,
  ...
```

## 3. Calculate the preparation time in minutes

The preparation time is how long it takes to get the lasagna ready before it is put in the over.
It takes 2 minutes to prepare each layer.

```sh
$ echo '{"number_of_layers": 3}' | jq -f lasagna.jq
{
  ...
  "preparation_time": 6,
  ...
```

## 4. Calculate the total working time in minutes

Calculate how many minutes in total you've worked on cooking the lasagna.
This is the sum of the preparation time in minutes and the time in minutes the lasagna has spent in the oven at the moment.

```sh
$ echo '{"actual_minutes_in_oven": 10, "number_of_layers": 2}' | jq -f lasagna.jq
{
  ...
  "total_time": 14,
  ...
```
