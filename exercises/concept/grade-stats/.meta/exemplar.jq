def letter_grade:
  if   IN(range(90; 101)) then "A"
  elif IN(range(80; 90))  then "B"
  elif IN(range(70; 80))  then "C"
  elif IN(range(60; 70))  then "D"
  else "F"
  end
;

def count_letter_grades:
  {A: 0, B: 0, C: 0, D: 0, F: 0} as $counts
  | to_entries
  | reduce .[] as $entry ($counts; .[$entry.value | letter_grade] += 1)
;
