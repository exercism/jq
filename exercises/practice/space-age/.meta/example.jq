def two_decimal: ((. * 100) | round) / 100;

. as {$planet, $seconds}
| 31557600  as $seconds_per_earth_year
| {
    "Mercury": 0.2408467,
    "Venus": 0.61519726,
    "Earth": 1.0,
    "Mars": 1.8808158,
    "Jupiter": 11.862615,
    "Saturn": 29.447498,
    "Uranus": 84.016846,
    "Neptune": 164.79132
  }
| if has($planet)
  then ($seconds / $seconds_per_earth_year / .[$planet]) | two_decimal
  else "not a planet" | halt_error
  end
