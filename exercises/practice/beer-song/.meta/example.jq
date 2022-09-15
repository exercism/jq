def if_1(a; b): if . == 1 then a else b end;

def bottles:
    if   . == 0 then "No more"
    elif .  < 0 then "99"
    else             tostring
    end
    + " bottle\(if_1(""; "s")) of beer";

def line1:
    bottles | "\(.) on the wall, \(ascii_downcase).";

def line2:
    if . == 0 then "Go to the store and buy some more"
    else           "Take \(if_1("it"; "one")) down and pass it around"
    end
    + ", \(. - 1 | bottles | ascii_downcase) on the wall.";


[
    range(.startBottles; .startBottles - .takeDown; -1)
    | ["", line1, line2]
]
| add
| .[1:]
