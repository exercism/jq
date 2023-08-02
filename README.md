# Exercism jq track

## TODO

Create more: concepts, concept exercises, practice exercises.

## Foregone exercises

| Exercise                  |                                       Reason                                       |
| ------------------------- | :--------------------------------------------------------------------------------: |
| grains                    | jq uses [IEEE 754 floats to represent numbers][numbers]: only 53 bits of precision |
| allergies                 |                                no bitwise operators                                |
| secret-handshake          |                                         "                                          |
| variable-length-quantity  |                                         "                                          |
| ledger                    |                       I hate creating refactoring exercises                        |
| markdown                  |                                         "                                          |
| tree-building             |                                         "                                          |
| dnd-character             |                        no builtin randomness functionality                         |
| robot-name                |                                         "                                          |
| bank-account              |                             no parallelism/concurrency                             |
| parallel-letter-frequency |                                         "                                          |
| hangman                   |                         no functional reactive programming                         |
| grep                      |                                  no IO functions                                   |
| paasio                    |                                         "                                          |

bitwise operations: they [can be implemented][jbol-bitwise], but that's too much I think.
Unless we provide it as a library to include ...

JBOL includes an implementation of [pseudo-random numbers][jbol-chance].

[numbers]: https://github.com/jqlang/jq/wiki/FAQ#numbers
[jbol-bitwise]: https://github.com/fadado/JBOL/blob/master/fadado.github.io/math/bitwise.jq
[jbol-chance]: https://github.com/fadado/JBOL/blob/master/fadado.github.io/math/chance.jq

## Contributing

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) document for details about adding concepts, learning exercises and practice exercises.
