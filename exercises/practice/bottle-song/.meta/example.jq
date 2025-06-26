def bottles:
    [ "No", "One", "Two", "Three", "Four",
      "Five", "Six", "Seven", "Eight", "Nine", "Ten" ][.]
    + " green bottle"
    + (if . == 1 then "" else "s" end);

def line1:
    "\(bottles) hanging on the wall,";

def line2:
    "There'll be \(. - 1 | bottles | ascii_downcase) hanging on the wall.";

[
    range(.startBottles; .startBottles - .takeDown; -1)
    | [ "",
        line1,
        line1,
        "And if one green bottle should accidentally fall,",
        line2
      ]
]
| add
| .[1:]
