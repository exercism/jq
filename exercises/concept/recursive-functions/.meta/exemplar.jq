## These are straightforward recursive functions.
## They might blow up the stack with large input arrays.
#
# def array_add:
#   if length == 0 then 0
#   else first + (.[1:] | array_add)
#   end;
#
# def array_reverse:
#   if length == 0 then []
#   else (.[1:] | array_reverse) + [.[0]]
#   end;
#
# def array_map(f):
#   if length == 0 then []
#   else [.[0] | f] + (.[1:] | array_map(f))
#   end;

# Versions using helper functions that are tail call optimized

def array_add:
  def _adder:
    # input: {input: array, sum: number}
    if (.input | length) == 0 then
      .sum
    else
      {
        input: .input[1:],
        sum: (.sum + .input[0])
      } | _adder
    end;
  {input: ., sum: 0} | _adder;

def array_reverse:
  def _reverser:
    # input: {input: array, reversed: array}
    if (.input | length) == 0 then
      .reversed
    else
      {
        input: .input[1:],
        reversed: ([.input[0]] + .reversed)
      } | _reverser
    end;
  {input: ., reversed: []} | _reverser;

 def array_map(f):
   def _mapper:
    # input: {input: array, mapped: array}
    if (.input | length) == 0 then
      .mapped
    else
      {
        input: .input[1:],
        mapped: (.mapped + [.input[0] | f])
      } | _mapper
    end;
  {input: ., mapped: []} | _mapper;
