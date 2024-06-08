def turn(t):
  {
    "north": {"left": "west",  "right": "east"},
    "east":  {"left": "north", "right": "south"},
    "south": {"left": "east",  "right": "west"},
    "west":  {"left": "south", "right": "north"}
  } as $dir
  | .direction |= $dir[.][t]
;

def advance:
  if   .direction == "north" then .position.y += 1
  elif .direction == "east"  then .position.x += 1
  elif .direction == "south" then .position.y -= 1
  elif .direction == "west"  then .position.x -= 1
  end
;

def operate(instructions):
  [instructions[0:1], instructions[1:(instructions|length)]] as [$first, $rest]
  | if   $first == "A" then advance       | operate($rest)
    elif $first == "L" then turn("left")  | operate($rest)
    elif $first == "R" then turn("right") | operate($rest)
    end
;

(.instructions // "") as $instructions
| .robot
| operate($instructions)
