def mapping:
  [
    ( "abcdefghijklmnopqrstuvwxyz" as $alphabet
      | [($alphabet / ""), ($alphabet / "" | reverse)]
      | transpose[]
      | {(.[0]): .[1]}
    ),
    ( range(10)
      | tostring
      | {(.): .}
    ) 
  ] | add;

def grouped: [scan(".{1,5}")] | join(" ");

def decode($map): . / "" | map($map[.] // "") | join("") ;

def encode($map): decode($map) | grouped;

.input.phrase |= ascii_downcase
| if   .property == "encode" then .input.phrase | encode(mapping)
  elif .property == "decode" then .input.phrase | decode(mapping)
  else empty
  end

# It would be nice to have a dynamic way to dispatch there.
# There isn't one: functions are "second-class" in jq.
# See https://github.com/stedolan/jq/wiki/jq-Language-Description#The-jq-Language
