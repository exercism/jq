def transform:
  reduce .input.students[] as $student ({seen: [], school: []};
    $student as [$name, $grade]
    | .seen as $seen
    | if $name | IN($seen[]) | not then 
        .seen += [$name]
        | .school[$grade] |= (. + [$name] | unique)
      end
  )
  | .school
;

def get_grade($wanted):
  transform
  | .[$wanted]
;

if .property == "roster" then transform | add
elif .property == "grade" then get_grade(.input.desiredGrade)
end
| . // []
