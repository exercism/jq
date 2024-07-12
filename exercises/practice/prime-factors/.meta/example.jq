{ number: .value, factor: 2, primes: [] }
| until(
    .factor * .factor > .number;
    until(
      .number % .factor != 0;
      .number /= .factor | .primes += [.factor]
    )
    | .factor += 1
  )
| .primes + [if .number > 1 then .number else empty end]
