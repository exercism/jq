def assert(cond; errmsg):
  if (cond | not) then errmsg | halt_error(1)
  else .
  end;

assert((.strand1 | length) == (.strand2 | length); "strands must be of equal length")
| [(.strand1 | explode), (.strand2 | explode)]
| transpose
| map(select(.[0] != .[1]))
| length
