def labelled($unit):
    def get_prefix_idx:
        if .value == 0 or .value % 1000 != 0
          then .
          else .value /= 1000 | .idx += 1 | get_prefix_idx
        end;

    {value: ., idx: 0}
    | get_prefix_idx
    | {value, unit: (["", "kilo", "mega", "giga"][.idx] + $unit)};


{
    black:   0,
    brown:   1,
    red:     2,
    orange:  3,
    yellow:  4,
    green:   5,
    blue:    6,
    violet:  7,
    grey:    8,
    white:   9
} as $colors
| .colors
| (10 * $colors[.[0]] + $colors[.[1]]) * pow(10; $colors[.[2]])
| labelled("ohms")
