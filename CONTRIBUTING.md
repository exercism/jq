# Contributing to the jq track

---

## Creating concepts

These are a big amount of work, but I think I've figured out a decent checklist to focus the effort needed.

1. select an exercise
   - this was surprisingly tricky for the early exercises, but it seems I'm kind of aligning with Javascript now.
   - take inspiration from other languages, it's OK to "fork" an exercise and customize it for jq
   - look at [the existing stories](https://exercism.org/docs/building/tracks/stories) and how other languages applied to their concepts.
   - keep in mind the [exercism guidance about concept exercises](https://exercism.org/docs/building/product/concept-exercises)
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
1. determine where in the syllabus it goes
   - what are the prerequisites for this concept?
1. revisit practice exercises "practices" and "prerequisites"
   - are we moving practice exercises into this concept?

The following can be cut-n-pasted into the description of an issue to track progress:

```none
- [ ] select an exercise
- [ ] make a first draft of the design.md file, laying out the goals for the concept & exercise.
- [ ] add concept and exercise to the "root" config.json
- [ ] edit concept's and exercise's config.json
- [ ] write tests, exemplar and stub
- [ ] edit instructions
- [ ] revisit design.md
- [ ] write about.md
- [ ] copy and prune to create introduction.md
- [ ] edit hints
- [ ] add links
- [ ] determine where in the syllabus it goes
- [ ] revisit practice exercises "practices" and "prerequisites"
```

---

### Difficulty ratings

We only use 3 difficulty values since the website only displays easy/medium/hard.

- an "easy" exercise has difficulty 2.
- a "medium" exercise has difficulty 5.
- a "hard" exercise has difficulty 9.

---

## How to port an exercise

Using `grep` as an example:

- fork this repo
- create a branch
- run the script to generate the exercise: follow the prompts and instructions

  ```sh
  ./bin/add-exercise grep
  ```

- implement the example solution `./exercises/practice/grep/.meta/example.jq`
- test with

  ```sh
  bin/validate_one_exercise ./exercises/practice/grep
  ```

- when the tests pass, reconsider the difficulty for the exercise in `config.json`: the list of practice exercises is sorted by difficulty.
- should you create a `./exercises/practice/grep/.docs/instructions.append.md`?
  Is there any specific new aspect of `jq` that needs to be written about?
- check for any configlet errors

  ```sh
  bin/configlet lint
  ```

- commit, push and create a PR.

---

## Prettier

We use [Prettier][prettier] to keep our markdown files tidy.
Read the [.prettierignore][prettier-ignore] file for more details.

[prettier]: https://prettier.io
[prettier-ignore]: https://github.com/exercism/jq/blob/main/.prettierignore
