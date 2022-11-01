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
| paasio                    |                                  no IO functions                                   |

bitwise operations: they [can be implemented][jbol-bitwise], but that's too much I think.
Unless we provide it as a library to include ...

JBOL includes an implementation of [pseudo-random numbers][jbol-chance].

[numbers]: https://github.com/stedolan/jq/wiki/FAQ#numbers
[jbol-bitwise]: https://github.com/fadado/JBOL/blob/master/fadado.github.io/math/bitwise.jq
[jbol-chance]: https://github.com/fadado/JBOL/blob/master/fadado.github.io/math/chance.jq

## How to port an exercise

Using `square-root` as an example:

- fork this repo
- create a branch
- copy an existing exercise

  ```sh
  cp -r ./exercises/practice{reverse-string,square-root}
  ```

- edit the exercise config file to set the right file names: `./exercises/practice/square-root/.meta/config.json`
- generate the test script

  ```sh
  bin/generate_tests square-root
  ```

  If this creates a dubious-looking test suite, you may need to create it manually
  (the test generator currently does not handle exercises where there are nested "cases" objects in the problem-specifications canonical-data.json file).

- implement the example solution `./exercises/practice/square-root/.meta/example.jq`
- test with

  ```sh
  bin/validate_one_exercise ./exercises/practice/square-root
  ```

- when the tests pass, add the exercise to `config.json` in the `.exercises.practice` array:
  the list of practice exercises is sorted by difficulty.
- sync the exercise with problem-specifications:

    ```sh
    bin/configlet sync -e square-root --docs --update
    bin/configlet sync -e square-root --metadata --update
    bin/configlet sync -e square-root --tests --update
    bin/configlet lint
    ```

- commit, push and create a PR.
