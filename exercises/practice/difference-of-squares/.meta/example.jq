def seq: [range(1; . + 1)];
def square: . * .;
def squareOfSum: seq | add | square ;
def sumOfSquares: seq | map(square) | add ;

.property as $fn
| .input.number
| if   $fn == "squareOfSum" then squareOfSum
  elif $fn == "sumOfSquares" then sumOfSquares
  else (squareOfSum - sumOfSquares)
  end
