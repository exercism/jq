# Instructions

You are an avid bird watcher that keeps track of how many birds have visited your garden in the last seven days.

You have five tasks, all dealing with the numbers of birds that visited your garden.

## 1. Check what the counts were last week

You store your bird counts in JSON format.
A "main" array stores arrays of weekly counts.
Each weekly count is an array of seven integers, one number for each day of the week.
You always append new weeks at the end of the main array.
Implement the filter that returns last week's counts.

```sh
$ cat bird-counting-data.json
[
  ...,
  [0, 2, 5, 3, 7, 8, 4],
  [4, 5, 9, 10, 9, 4, 3]
]

$ jq -f bird-count.jq < bird-counting-data.json
{
  "last_week": [0, 2, 5, 3, 7, 8, 4],
  ...
```

## 2. Check how many birds visited yesterday

Implement the filter to return how many birds visited your garden yesterday.
The bird counts are ordered by day, with the first element being the count of the oldest day, and the last element being today's count.

```jq
$ jq -f bird-count.jq < bird-counting-data.json
{
  ...
  "yesterday": 4,
  ...
```

## 3. Calculate the total number of visiting birds

Implement the filter to return the total number of birds that have visited your garden this week.

```jq
$ jq -f bird-count.jq < bird-counting-data.json
{
  ...
  "total": 44,
  ...
```

## 4. Calculate the number of busy days

Some days are busier than others.
A busy day is one where five or more birds have visited your garden.
Implement the filter to return the number of busy days this week:

```jq
$ jq -f bird-count.jq < bird-counting-data.json
{
  ...
  "busy_days": 4,
  ...
```

## 5. Check if there was a day with no visiting birds

Implement the filter that returns `true` if there was any day this week when zero birds visited the garden; otherwise, return `false`:

```jq
$ jq -f bird-count.jq < bird-counting-data.json
{
  ...
  "has_day_without_birds": false
}
```
