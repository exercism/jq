def trim: sub("^\\s+"; "") | sub("\\s+$"; "");

def message:
  .[index(":") + 1:] | trim
;

def log_level:
  .[1:index("]")] | ascii_downcase
;

def reformat:
  "\(message) (\(log_level))"
;
