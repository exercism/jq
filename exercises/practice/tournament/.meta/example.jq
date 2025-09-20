# Input: an object representing the teams in the league.
# Output: the league object modified.
def processMatch($match):
  $match as [$home, $away, $result]
  | if (has($home) | not) then .[$home] = {"w": 0, "d": 0, "l": 0} end
  | if (has($away) | not) then .[$away] = {"w": 0, "d": 0, "l": 0} end
  | if   $result == "win"  then .[$home].w += 1 | .[$away].l += 1
    elif $result == "loss" then .[$home].l += 1 | .[$away].w += 1
    elif $result == "draw" then .[$home].d += 1 | .[$away].d += 1
    end
;

# Input: an array of 3-element arrays: home, away, result.
# Output: an array of 6-element arrays: team, mp, w, d, l, p.
def tally:
  reduce .[] as $match ({}; processMatch($match))
  | to_entries
  | map([
      .key,                               # team name
      .value.w + .value.d + .value.l,     # matches played
      .value.w,                           # wins
      .value.d,                           # draws
      .value.l,                           # losses
      3 * .value.w + .value.d             # points
    ])
;

def padright(n): tostring + (" " * n) | .[:n];
def padleft(n):  (" " * n) + tostring | .[-n:];

def tabular:
  [.[0] | padright(30)] + [.[1:][] | padleft(2)]
  | join(" | ")
;

############################################################
.matches
| map(split(";"))
| tally
| sort_by(.[-1] * -1, .[0])             # sort by points descending then name ascending
| ["Team", "MP", "W", "D", "L", "P"], .[]
| tabular
