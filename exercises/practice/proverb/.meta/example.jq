.strings
| length as $n
| .[0] as $first
| [.[:-1], .[1:]]
| transpose
| map("For want of a \(.[0]) the \(.[1]) was lost.")
| if ($n > 0) then . + ["And all for the want of a \($first)."] else .  end
