# perhaps an over-reliance on `reduce`, but this is just a proof

def between($lo; $hi): $lo <= . and . < $hi;

def count_neighbouring_mines($i; $j):
  . as $m
  | [[-1,-1],[-1,0],[-1,1],
     [ 0,-1],       [ 0,1],
     [ 1,-1],[ 1,0],[ 1,1]] as $neighbours
  | reduce $neighbours[] as [$di, $dj] (
      0;
      . + if  ($i + $di | between(0; $m | length)) and
              ($j + $dj | between(0; $m[$i] | length)) and
              $m[$i + $di][$j + $dj] == 99
          then 1
          else 0
          end
    )
;

def annotate:
  . as $m
  | reduce range(length) as $i ([]; . + [
      reduce range($m[$i] | length) as $j ([]; . + [
        if $m[$i][$j] == 99
          then 99
          else ($m | count_neighbouring_mines($i; $j))
        end
      ])
    ])
;

# input is a string of newline-terminated rows.
# "*" indicates a mine; "." indicates no mine.
# output is an array of arrays of integers.
# e.g.  "*..\n...\n..*\n" => [[99,0,0],[0,0,0],[0,0,99]]
#
def to_numeric_array:
  if . == "\n" then [[]] else
    rtrimstr("\n")
    | split("\n")
    | map([ split("")[] | if . == "." then 0 else 99 end ])
  end
;

# reverse of above.
#   [[99,1,0],[1,2,1],[0,1,99]] => ["*1.","121",".1*"]
def to_string_array:
  map(
    map(if . == 0 then "." elif . == 99 then "*" else tostring end)
    | join("")
  )
;
    
to_numeric_array
| annotate
| to_string_array
