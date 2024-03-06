def to_decimal(base): reduce .[] as $d (0; base * . + $d);


def to_base(base):
  def helper:
    if .n == 0
      then if .digits == [] then [0] else .digits end
      else
        (.n % base) as $digit
        | {n: ((.n - $digit) / base), digits: ([$digit] + .digits)}
        | helper
    end;
  {n: ., digits: []} | helper;


def validate:
  .inputBase as $in
  | if $in < 2
      then "input base must be >= 2" | halt_error
    end
  | if .outputBase < 2
      then "output base must be >= 2" | halt_error
    end
  | if (.digits | map(0 <= . and . < $in) | all | not)
      then "all digits must satisfy 0 <= d < input base" | halt_error
    end
  ;


validate
| [.inputBase, .outputBase] as [$in, $out]
| .digits
| to_decimal($in)
| to_base($out)
