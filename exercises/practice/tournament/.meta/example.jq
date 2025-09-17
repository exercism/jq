# Input is an object representing the teams in the league.
# If the team name has not yet been seen, add its initial stats.
def initTeam($name):
  if (has($name) | not) then
    .[$name] = {"w": 0, "d": 0, "l": 0}
  end
;

# Input is an object representing the teams in the league.
# Output is the league modified.
def processMatch($match):
  $match as [$home, $away, $result]
  | initTeam($home)
  | initTeam($away)
  | if   $result == "win"  then .[$home].w += 1 | .[$away].l += 1
    elif $result == "loss" then .[$home].l += 1 | .[$away].w += 1
    elif $result == "draw" then .[$home].d += 1 | .[$away].d += 1
    end
;

[., inputs]                             # slurp all input into an array
| map(split(";"))
| reduce .[] as $match ({}; processMatch($match))
| to_entries
| map([
    .key,                               # team name
    .value.w + .value.d + .value.l,     # matches played
    .value.w,                           # wins
    .value.d,                           # draws
    .value.l,                           # losses
    3 * .value.w + .value.d             # points
  ])
| sort_by(.[-1] * -1, .[0])             # sort by points descending then name ascending
| ["Team", "MP", "W", "D", "L", "P"], .[]
| @csv
