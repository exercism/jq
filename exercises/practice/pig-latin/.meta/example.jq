# `capture` outputs empty if no match.
# Test all the patterns, and take the *first* non-empty result.
# This function uses an array of filters: the input is fed to each of them.
def translate:
  [ capture("^ (?<prefix>             ) (?<rest> (?:xr|yt).+ )"; "x")   # xray
  , capture("^ (?<prefix> [^aeiou]*qu ) (?<rest>          .+ )"; "x")   # squeeze
  , capture("^ (?<prefix> [^aeiou]+   ) (?<rest>         y.* )"; "x")   # rhyme
  , capture("^ (?<prefix> [^aeiou]+   ) (?<rest>          .* )"; "x")   # beer, xkcd
  , {prefix: "", rest: .}                                               # apple
  ]
  | first
  | .rest + .prefix + "ay"
;

.phrase
| split(" ")
| map(translate)
| join(" ")
