def preprocess_case:
    if $slug == "flower-field" then
        .input.garden = (.input.garden | map(gsub(" "; ".")))
        | .expected = (.expected | map(gsub(" "; ".")))
    else
        .
    end
    ;

def format_input:
    if $slug == "flower-field" then
        .garden | join("\n")
    else
        .
    end
    ;
