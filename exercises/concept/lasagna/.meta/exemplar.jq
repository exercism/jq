# constants
40 as $expected_minutes_in_oven |
2 as $preparation_time_per_layer |

# default values
(.actual_minutes_in_oven // 0) as $actual |
(.number_of_layers // 1) as $layers |

# calculated values
($preparation_time_per_layer * $layers) as $preparation_time |

# output object
{
    $expected_minutes_in_oven,
    remaining_minutes_in_oven: ($expected_minutes_in_oven - $actual),
    $preparation_time,
    total_time: ($preparation_time + $actual)
}
