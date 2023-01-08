def is_valid_command:
  test("^chatbot\\b"; "i");

def remove_emoji:
  gsub("\\bemoji[0-9]+\\b"; "");

def check_phone_number:
  " [(][+] \\d{2} [)]   # country code
    \\s+ \\d{3}         # area code
    -    \\d{3}         # exchange
    -    \\d{3}         # station number
  " as $regex
  | if test($regex; "x") then
      "Thanks! Your phone number is OK."
    else
      "Oops, it seems like I can't reach out to \(.)."
    end;

def get_domains:
  [scan("(?:\\w+\\.)+\\w+")];

def nice_to_meet_you:
  capture("my name is (?<name>\\S+)"; "i")
  | "Nice to meet you, \(.name)";

def parse_csv:
  # split/1 takes a string
  # split/2 takes a regex and flags
  split(",[[:blank:]]*"; "");
