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

## Creating concepts

These are a big amount of work, but I think I've figured out a decent checklist to focus the effort needed.

1. select an exercise
   - this was surprisingly tricky for the early exercises, but it seems I'm kind of aligning with Javascript now.
1. make a first draft of the design.md file, laying out the goals for the concept & exercise.
1. add concept and exercise to the "root" config.json
1. edit concept's and exercise's config.json
1. write tests, exemplar and stub
   - doing this _after_ altering the config files enables the bin/validate script
1. edit instructions
1. revisit design.md
   - once the exercise is handled, we can think a little deeper about what concepts the exercise demonstrates
1. write about.md
   - this is the most work to get right
1. copy and prune to create introduction.md
   - the introduction is seen _before_ the exercise is completed, and the about is shown thereafter
1. edit hints
1. add links

## How to port an exercise

Using `grep` as an example:

- fork this repo
- create a branch
- add the exercise to `config.json` (just pick a difficulty value, this can always be changed later)

  ```sh
  jq --arg slug "grep" \
     --arg name "Grep" \
     --arg uuid "$(bin/configlet uuid)" \
     --argjson difficulty 5 \
     --argjson practices '[]' \
     --argjson prerequisites '[]' \
     '.exercises.practice += [$ARGS.named]' \
     config.json \
  | sponge config.json
  ```

  This uses the `sponge` utility (from the linux `moreutils` package) to write back to the original file.
  `jq` does not have a `-i` option like sed.
  If you {don't have,can't install} sponge then do:

  ```sh
  jq ... config.json > config.tmp && mv config.tmp config.json
  ```

- use configlet to create the exercise directory structure:

  ```sh
  bin/fetch-configlet
  bin/configlet sync --exercise grep --docs --update --yes
  bin/configlet sync --exercise grep --metadata --update --yes
  bin/configlet sync --exercise grep --tests include --update
  ```

- populate the exercise config file:
  ```sh
  conf=./exercises/practice/grep/.meta/config.json
  jq --arg slug grep --arg author "yourGithubHandle" '
    .authors += [$author]
    | .files.solution = ["\($slug).jq"]
    | .files.test = ["test-\($slug).bats"]
    | .files.example = [".meta/example.jq"]
  ' "$conf" | sponge "$conf"
  ```

- copy `./exercises/practice/grep/bats-extra.bash` from another exercise
- create the stub solution file `./exercises/practice/grep/grep.jq` (or copy it from another exercise)
- generate the test script

  ```sh
  bin/generate_tests grep
  ```

  If this creates a dubious-looking test suite, or if you have specific intentions, you may need to create it manually.
  If that's the case, consider the contents of the `generate_tests.json` config file.

- implement the example solution `./exercises/practice/grep/.meta/example.jq`
- test with

  ```sh
  bin/validate_one_exercise ./exercises/practice/grep
  ```

- when the tests pass, reconsider the difficulty for the exercise in `config.json`: the list of practice exercises is sorted by difficulty.
- should you create a `./exercises/practice/grep/.docs/instructions.append.md`?
  Is there any specific new aspect of `jq` that needs to be written about?
- re-sync the exercise with problem-specifications:

    ```sh
    bin/configlet sync -e grep
    bin/configlet lint
    ```

- commit, push and create a PR.
