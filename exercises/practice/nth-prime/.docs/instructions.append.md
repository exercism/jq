# dummy

## The `--argjson` option

The tests use the `jq` option `--argjson n 1`.
This creates a jq variable named `$n` holding the _**number**_ value `1`.

Contrast this with the option `--arg n 1`
which creates a jq variable named `$n` holding the _**string**_ value `"1"`.

In your solution, use `$n` as the input to get the nth prime.

See [Invoking jq][man-invoke] in the manual.

[man-invoke]: https://jqlang.github.io/jq/manual/v1.6/#Invokingjq
