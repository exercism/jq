def animals($i):
  ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"][$i - 1]
;

def catchphrase($i):
  [
    "I don't know why she swallowed the fly. Perhaps she'll die.",
    "It wriggled and jiggled and tickled inside her.",
    "How absurd to swallow a bird!",
    "Imagine that, to swallow a cat!",
    "What a hog, to swallow a dog!",
    "Just opened her throat and swallowed a goat!",
    "I don't know how she swallowed a cow!",
    "She's dead, of course!"
  ][$i - 1]
;

def verse($n):
  animals($n) as $animal
  | [ 
      "I know an old lady who swallowed a \($animal).",
      catchphrase($n)
    ]
  | if ($animal | IN("fly", "horse") | not) then
      . + [
        foreach range($n; 1; -1) as $i (null;
          "She swallowed the \(animals($i)) to catch the \(animals($i - 1))"
          + if animals($i - 1) == "spider"
              then " that wriggled and jiggled and tickled inside her."
              else "."
            end
        )
      ] + [catchphrase(1)]
    end
  | join("\n")
;

[ foreach range(.startVerse; .endVerse + 1) as $i (null; verse($i)) ]
| join("\n\n")
