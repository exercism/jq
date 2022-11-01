# This solution uses functions that act as closures:
# an array of known primes is passed as an argument to the
# function, and an inner recursive function is used do
# the work to solve the function.
#
# An implementation that passes arrays around as "state"
# (input to the function) is much much slower.


# input: the candidate to be tested
# arg:   an array of known primes
# output: boolean result
#
def is_prime($primes):
    def _is_prime:
        . as [$idx, $limit, $candidate] |
        if $primes[$idx] > $limit then true
        elif $candidate % $primes[$idx] == 0 then false
        else [$idx + 1, $limit, $candidate] | _is_prime
        end;

    [0, sqrt, .] | _is_prime;


# input: ignored
# arg: an array of known primes so far
# output: the array of known primes plus the newest prime
#
def next_prime($primes):
    # this inner function takes the candidate as input
    def _next_prime:
        if is_prime($primes)
        then $primes + [.]
        else . + 2 | _next_prime
        end;

    $primes[-1] + 2 | _next_prime;


if   .number == 0 then "there is no zeroth prime" | halt_error
elif .number == 1 then 2
else reduce range(2; .number) as $_ ([2, 3]; next_prime(.)) | .[-1]
end
