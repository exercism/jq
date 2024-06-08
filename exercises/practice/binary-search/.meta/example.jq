def indexof(target; left; right):
  if left > right then "value not in array" | halt_error end
  | ((left + right) / 2 | floor) as $mid
  | if   target == .[$mid] then $mid
    elif target <  .[$mid] then indexof(target; left; $mid - 1)
    else                        indexof(target; $mid + 1; right)
    end
;

.value as $target | .array | indexof($target; 0; length - 1)
