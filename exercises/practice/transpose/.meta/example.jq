# trim nulls from the end of an array
def rtrim_nulls:
    if .[-1] == null
    then .[:-1] | rtrim_nulls
    else .
    end;

# Input is an array of codepoints and nulls.
# Trim trailing nulls. Other nulls become spaces.
def restringify:
    rtrim_nulls | map(. // 32) | implode;

.lines | map(explode) | transpose | map(restringify)
