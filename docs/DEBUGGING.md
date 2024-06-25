# Tips for debugging in `jq`

`jq` comes with a handy [`debug`][debug] filter.
Use it while you are developing your exercise solutions to inspect the data that is currently in the jq pipline.

`debug` print a "debug array" to **stderr**.
The first element of the array is the string "DEBUG:".
The second element depends on how you invoke `debug`:

1. the zero-arity debug function puts a compact representation of the input into the array:

    ```sh
    jq -n '[11, 22, 33] | debug | map(. * 2)'
    ```

    outputs

    ```none
     ["DEBUG:",[11,22,33]]
     [
       22,
       44,
       66
     ]
    ```

2. the one-arity version pipes the input through the given filter, prints the debug message, and outputs the input unchanged:

    ```sh
    jq -n '[11, 22, 33] | debug("length: \(length), last: \(.[-1])") | map(. * 2)'
    ```

    ```none
     ["DEBUG:","length: 3, last: 33"]
     [
       22,
       44,
       66
     ]
    ```

    The filter doesn't need to be a string, it can be anything, including multiple comma-separated expressions for "multi-line" debug output:

    ```sh
    jq -n '[11, 22, 33] as $a | 44 | debug("I am here:", $a, .)'
    ```

    ```none
    ["DEBUG:","I am here:"]
    ["DEBUG:",[11,22,33]]
    ["DEBUG:",44]
    44
    ```


[debug]: https://jqlang.github.io/jq/manual/v1.7/#debug
