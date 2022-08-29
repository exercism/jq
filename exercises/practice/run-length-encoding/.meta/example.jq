# scan(regex), when using capturing parentheses, outputs a stream of arrays:
#    "bbbacc" | scan("(.)(\\1*)")
# outputs
#    ["b", "bb"]
#    ["a", ""]
#    ["c", "c"]
#
def encode:
  reduce scan("(.)(\\1*)") as $s ("";
    (1 + ($s[1] | length) | tostring) as $count |
    . + if $count == "1" then "" else $count end + $s[0]
  );

def decode:
  reduce scan("(\\d*)(\\D)") as $s ("";
    . + ($s[1] * if $s[0] == "" then 1 else ($s[0] | tonumber) end)
  );
