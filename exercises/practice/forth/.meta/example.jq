# The "global state" is encapsulated in an object: { stack, macros }
# - `stack` is an array of integers.
# - `macros` is an object mapping a string to an array of words.
#
# This object gets passed as input to almost all the functions in this
# program.
#
# The functions will manipulate either the stack or the macros
# and output the state object.

def isnumeric: try (tonumber | true) catch false;

############################################################
# stack manipulation functions

def push(num): .stack += [num];

def need(n):
  (.stack | length) as $len
  | if   n > 0 and $len == 0 then "empty stack" | halt_error
    elif n > 1 and $len == 1 then "only one value on the stack" | halt_error
    else .
    end;

def dup:   need(1) | .stack += [.stack[-1]];
def drop:  need(1) | .stack  = .stack[:-1];
def swap:  need(2) | .stack  = .stack[:-2] + [.stack[-1], .stack[-2]];
def over:  need(2) | .stack += [.stack[-2]];

def plus:  need(2) | .stack  = .stack[:-2] + [.stack[-2] + .stack[-1]];
def minus: need(2) | .stack  = .stack[:-2] + [.stack[-2] - .stack[-1]];
def mul:   need(2) | .stack  = .stack[:-2] + [.stack[-2] * .stack[-1]];
def div:   need(2) | .stack  = try (.stack[:-2] + [.stack[-2] / .stack[-1] | floor])
                               catch ("divide by zero" | halt_error);

############################################################
# macros manipulation

def record_macro(words):
  [.macros, words[0], words[1:]] as [$m, $name, $defn]
  | if ($name | isnumeric) then "illegal operation" | halt_error
    else .macros[$name] = reduce $defn[] as $w ([]; . + ($m[$w] // [$w]))
    end;

############################################################
# driver function

def evaluate($word):
  if ($word | isnumeric) then push($word | tonumber)
  elif .macros[$word]?   then reduce .macros[$word][] as $w (.; evaluate($w))
  elif $word == "+"      then plus    # "add" is builtin
  elif $word == "-"      then minus   # "sub" is builtin
  elif $word == "*"      then mul
  elif $word == "/"      then div
  elif $word == "dup"    then dup
  elif $word == "drop"   then drop
  elif $word == "swap"   then swap
  elif $word == "over"   then over
  else "undefined operation" | halt_error
  end;

############################################################
# MAIN
# - initializing the state object in the `reduce` statement

reduce .instructions[] as $i ({stack: [], macros: {}};
  ($i | ascii_downcase | split(" ")) as $words
  | if $words[0] == ":"
    then record_macro($words[1:-1])
    else reduce $words[] as $word (.; evaluate($word))
    end
)
| .stack
