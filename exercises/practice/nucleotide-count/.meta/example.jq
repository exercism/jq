# rationale: `explode` outputs an array of _codepoints_: I
#   want an array of 1-character strings.
# input: a string
# output: an array of strings, the characters of the input
def chars: explode | map([.] | implode);

reduce (.strand | chars | .[]) as $c ({A:0, C:0, G:0, T:0};
    if has($c)
        then .[$c] += 1
        else "Invalid nucleotide in strand" | halt_error
    end
)
