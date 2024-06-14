# Exercism jq track

## TODO

Create more: concepts, concept exercises, practice exercises.

## Foregone exercises

| Exercise                  | Reason                                                                             |
| ------------------------- | ---------------------------------------------------------------------------------- |
| allergies                 | No bitwise operators                                                               |
| bank-account              | No parallelism/concurrency                                                         |
| circular-buffer           | It feels beyond the realm of practical jq usage                                    |
| dnd-character             | No builtin randomness functionality                                                |
| grains                    | jq uses [IEEE 754 floats to represent numbers][numbers]: only 53 bits of precision |
| grep                      | No IO functions                                                                    |
| hangman                   | No functional reactive programming                                                 |
| ledger                    | I (glennj) hate creating refactoring exercises                                     |
| list-ops                  | No first-class functions                                                           |
| markdown                  | I (glennj) hate creating refactoring exercises                                     |
| paasio                    | No IO functions                                                                    |
| parallel-letter-frequency | No parallelism/concurrency                                                         |
| robot-name                | No builtin randomness functionality                                                |
| secret-handshake          | No bitwise operators                                                               |
| tree-building             | I (glennj) hate creating refactoring exercises                                     |
| variable-length-quantity  | No bitwise operators                                                               |

Bitwise operations: they [can be implemented][jbol-bitwise], but that's too much I think.
Unless we provide it as a library to include ...

JBOL includes an implementation of [pseudo-random numbers][jbol-chance].

[numbers]: https://github.com/jqlang/jq/wiki/FAQ#numbers
[jbol-bitwise]: https://github.com/fadado/JBOL/blob/master/fadado.github.io/math/bitwise.jq
[jbol-chance]: https://github.com/fadado/JBOL/blob/master/fadado.github.io/math/chance.jq

## Contributing

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) document for details about adding concepts, learning exercises and practice exercises.
