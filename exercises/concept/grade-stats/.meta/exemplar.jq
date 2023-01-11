def letter_grade:
  if   90 <= . and . <= 100 then "A"
  elif 80 <= . and . <   90 then "B"
  elif 70 <= . and . <   80 then "C"
  elif 60 <= . and . <   70 then "D"
  else "F"
  end
;

def count_letter_grades:
  reduce to_entries[] as $entry ({A: 0, B: 0, C: 0, D: 0, F: 0};
    .[$entry.value | letter_grade] += 1
  )
;
