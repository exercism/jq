# ignore

## Additional jq command line options

You'll notice extra options for `jq` in the tests.

```sh
run jq -s -R -c -f minesweeper.jq << 'END_INPUT'
```

What are they?

- `-s`

  This is "slurp" mode.
  Instead of handling the input as a stream of JSON objects,
  all the input will be slurped into an array.

  ```sh
  $ seq 5 | jq -c '.'
  1
  2
  3
  4
  5
  $ seq 5 | jq -s -c '.'
  [1,2,3,4,5]
  ```

- `-R`

  You may have seen `-r` already, to output "raw" strings (without quotes).
  This is the opposite.
  Each line of input is taken to be a string.

  Two examples:

  ```sh
  $ seq 5 | jq -R -c .
  "1"
  "2"
  "3"
  "4"
  "5"

  $ echo 42 | jq '. * 2'      # input is a JSON number
  84
  $ echo 42 | jq -R '. * 2'   # input is a JSON string
  "4242"
  ```

When you put these two options together, you _don't_ get an array of strings:
you get the entire input as a single string, including end-of-line newlines.

```sh
$ seq 5 | jq -s -R -c .
"1\n2\n3\n4\n5\n"
```

Handling this is part of the challenge of this exercise.
