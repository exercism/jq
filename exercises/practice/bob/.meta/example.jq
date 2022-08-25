((.heyBob // "") | gsub("\\s"; "")) as $input |
($input | endswith("?")) as $isQuestion |
($input | test("[[:upper:]]") and (test("[[:lower:]]") | not)) as $isShouting |

if ($input == "") then "Fine. Be that way!"
elif ($isQuestion and $isShouting) then "Calm down, I know what I'm doing!"
elif ($isQuestion) then "Sure."
elif ($isShouting) then "Whoa, chill out!"
else "Whatever."
end
