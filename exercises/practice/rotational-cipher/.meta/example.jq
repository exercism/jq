def makeMap($shift):
  "abcdefghijklmnopqrstuvwxyz" as $lower
  | ($lower | [.[$shift:26], .[0:$shift+1]] | add) as $rotated
  | reduce range(26) as $i ({};
      $lower[$i:$i+1] as $from
      | $rotated[$i:$i+1] as $to
      | . + {($from): $to} + {($from | ascii_upcase): ($to |  ascii_upcase)}
    )
;

def rotate:
  if .text == ""
  then .rotated
  else
    .text[0:1] as $char
    | .text |= .[1:length]
    | .rotated += (.rotation[$char] // $char)
    | rotate
  end
;

{"text": .text, "rotated": "", "rotation": makeMap(.shiftKey)} | rotate
