def toRna:  split("") |
            map({"G":"C", "C":"G", "A":"U", "T":"A"}[.]) |
            join("");
