[ "Alice", "Bob", "Charlie", "David", "Eve", "Fred", 
  "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"] as $names
| {C: "clover", G: "grass", R: "radishes", V: "violets"} as $plants

| .student as $student
| ($names | index($student)) as $offset

| .diagram / "\n"
| map(.[$offset * 2:$offset * 2 + 2])
| add / ""
| map($plants[.])
