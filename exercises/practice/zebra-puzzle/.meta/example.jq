# borrowed from https://github.com/fadado/JBOL/blob/master/fadado.github.io/array/tuple.jq
# module {
#     name: "array/tuple",
#     description: "Permutations on tuples",
#     namespace: "fadado.github.io",
#     author: {
#         name: "Joan Josep Ordinas Rosa",
#         email: "jordinas@gmail.com"
#     },
# };
#
# Permutations
# P(n) = n!
#
# example: 
#   [1,2,3] | permutations
# outputs
#   [1,2,3]
#   [1,3,2]
#   [2,1,3]
#   [2,3,1]
#   [3,1,2]
#   [3,2,1]

def permutations: #:: TUPLE => *TUPLE
    def choose: range(0;length);
    #
    if length == 0
    then []
    else
        # pick one and add to what's left permuted
        choose as $i
        | .[$i:$i+1] + (del(.[$i])|permutations)
    end
;
#########################################################
# functions as global constants
def first: 1;
def middle: 3;

def permute5: [range(first;first + 5)] | permutations;

def rightOf($house): . == $house + 1;
def nextTo($house): (. == $house + 1) or (. == $house - 1);

############################################################
# algorithm taken from Kotlin example solution

# The clues, and the functoin that implements them:
#   1. There are five houses.
#   2. The Englishman lives in the red house. (solveForNationality)
#   3. The Spaniard owns the dog. (solveForPets)
#   4. Coffee is drunk in the green house. (solveForBeverages)
#   5. The Ukrainian drinks tea. (solveForBeverages)
#   6. The green house is immediately to the right of the ivory house.  (solveForColour)
#   7. The Old Gold smoker owns snails. (solveForPets)
#   8. Kools are smoked in the yellow house. (solveForSmokes)
#   9. Milk is drunk in the middle house. (solveForBeverages)
#   10.The Norwegian lives in the first house. (solveForNationality)
#   11.The man who smokes Chesterfields lives in the house next to the man with the fox. (solveForPets)
#   12.Kools are smoked in the house next to the house where the horse is kept.
#   13.The Lucky Strike smoker drinks orange juice. (solveForSmokes)
#   14.The Japanese smokes Parliaments. (solveForSmokes)
#   15.The Norwegian lives next to the blue house. (solveForNationality)


def solveForPets($state):
    . as [$dog, $snails, $fox, $horse, $zebra] |

    if $dog == $state.spanish and                    # clue 3
        $snails == $state.oldGold and                # clue 7
        ($fox | nextTo($state.chesterfields)) and    # clue 11
        ($horse | nextTo($state.kools))              # clue 12
    then
        {
            drinksWater: $state.nationalities[$state.water],
            ownsZebra: $state.nationalities[$zebra]
        }
    else empty
    end;


def solveForSmokes($state):
    . as [$oldGold, $kools, $chesterfields, $luckyStrike, $parliaments] |

    if $kools == $state.yellow and                   # clue 8
        $luckyStrike == $state.orangeJuice and       # clue 13
        $parliaments == $state.japanese              # clue 14
    then
        ($state + {$oldGold, $kools, $chesterfields, $luckyStrike, $parliaments}) as $state
        | permute5
        | solveForPets($state)
    else empty
    end;


def solveForBeverages($state):
    . as [$coffee, $tea, $milk, $orangeJuice, $water] |

    if $coffee == $state.green and                   # clue 4
        $tea == $state.ukranian and                  # clue 5
        $milk == middle                              # clue 9
    then
        ($state + {$coffee, $tea, $milk, $orangeJuice, $water}) as $state
        | permute5
        | solveForSmokes($state)
    else empty
    end;


def solveForNationality($state):
    . as [$english, $spanish, $ukranian, $norwegian, $japanese] |

    if $english == $state.red and                    # clue 2
        $norwegian == first and                      # clue 10
        ($norwegian | nextTo($state.blue))           # clue 15
    then
        ( $state 
            + {$english, $spanish, $ukranian, $norwegian, $japanese}
            + {
                nationalities: (
                    [] 
                    | .[$english] = "EnglishMan"
                    | .[$spanish] = "Spaniard"
                    | .[$ukranian] = "Ukranian"
                    | .[$norwegian] = "Norwegian"
                    | .[$japanese] = "Japanese"
                )
                }
        ) as $state
        | permute5
        | solveForBeverages($state)
    else empty
    end;


def solveForColour($state):
    . as [$red, $green, $ivory, $yellow, $blue] |

    if $green | rightOf($ivory)                      # clue 6
    then
        ($state + {$red, $green, $ivory, $yellow, $blue}) as $state
        | permute5
        | solveForNationality($state)
    else empty
    end;


.property as $property
| permute5 
| solveForColour({}) 
| .[$property]
