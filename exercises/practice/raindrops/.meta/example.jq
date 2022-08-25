# store the input number
.number as $n |

# then, start with the result as an empty string
"" |

# add the sounds as applicable
if ($n % 3 == 0) then . + "Pling" else . end |
if ($n % 5 == 0) then . + "Plang" else . end |
if ($n % 7 == 0) then . + "Plong" else . end |

# output the number if there are no sounds
if (length == 0) then $n else . end
