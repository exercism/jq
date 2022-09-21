# Functions in `jq`

- _not_ part of the main filter pipeline
- is a filter expression: takes an input, emits output
- syntax -- `def funcname: expr;`
    - ends with semicolon
- can take arguments
    - semicolon-separated
    - arguments are _filters_ **not values**
        - like callbacks
            - "$arg" notation
            - ref https://glennj.github.io/jq/notes 
- same name, different arity
    - default values
- local scope for variables and nested functions
    - closures
- recursion
    - tailcall optimization for 0-arity functions only


## next steps

1. Pick a story for the concept exercise.
1. write the exercise design.md
1. write the exemplar and tests
1. then dig into the documentation
