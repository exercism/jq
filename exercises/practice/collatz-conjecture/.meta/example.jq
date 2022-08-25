def steps:
    # inner 0-arity function to enable tailcall recursion
    def _steps:
        if (.[0] == 1) then .[1]
        elif (.[0] % 2 == 0) then [.[0] / 2, .[1] + 1] | _steps
        else [.[0] * 3 + 1, .[1] + 1] | _steps
        end;

    if (. <= 0) then "Only positive integers are allowed" | halt_error(1)
    else [., 0] | _steps
    end;
