# dummy

## jq-specific Instructions

You'll be reading and writing CSV data for this exercise.
This isn't necessarily something you would think to reach for `jq` to do, but it is an interesting experiment.

Note that the tests use the `-r` and `-R` command-line options.
See [Invoking jq][invoke] for details.

Your program should output CSV-formatted text.
Instead of the table described above, we expect this:

```text
"Devastating Donkeys",3,2,1,0,7
"Allegoric Alaskans",3,2,0,1,6
"Blithering Badgers",3,1,0,2,3
"Courageous Californians",3,0,1,2,1
```

Refer to [Format strings][fmt] in the jq manual.

[invoke]: https://jqlang.org/manual/v1.7/#invoking-jq
[fmt]: https://jqlang.org/manual/v1.8/#format-strings-and-escaping
