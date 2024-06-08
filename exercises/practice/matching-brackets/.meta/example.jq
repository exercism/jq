# Repeatedly perform a global replacement until no more replacements are available.
def gsub_recursively(pattern; replacement):
  gsub(pattern; replacement) as $replaced
  | if $replaced != .
    then $replaced | gsub_recursively(pattern; replacement)
    end
;

.value
| gsub("[^[\\](){}]"; "")
| gsub_recursively("(\\[\\])|(\\(\\))|(\\{\\})"; "")
| . == ""
