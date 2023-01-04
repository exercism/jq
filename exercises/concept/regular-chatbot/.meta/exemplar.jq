# Given a certain command, help the chatbot recognize whether the command is valid or not.
#
# input: {string} a command
# output: {boolean} whether or not is the command valid
#
def is_valid_command:
  test("^chatbot\\b"; "i");


# Given a certain message, help the chatbot get rid of all the emoji's encryption throught the message.
#
# input: {string} message
# output: {string} The message without the emojis
def remove_emoji:
  gsub("\\bemoji[0-9]+\\b"; "");


# Given a certain phone number, help the chatbot recognize whether it is in the correct format.
#
# input: {string} number
# output: {string} the Chatbot response to the phone Validation
def check_phone_number:
  "^
   [(][+] \\d{2} [)]
   (?: [-\\x20] \\d{3} ){3}
   $" as $regex
  | if test($regex; "x") then
      "Thanks! You can now download me to your phone."
    else
      "Oops, it seems like I can't reach out to \(.)"
    end;


# Given a certain response from the user, help the chatbot get only the URLs
#
# input: {string} userInput
# output: {array} all the possible URLs that the user may have answered
def get_url:
  [scan("(?:\\w+\\.)+\\w+")];


# Greet the user using its full name data from the profile
#
# input: {string} sentence with name clause
# output: {string} Greeting from the chatbot
def nice_to_meet_you:
  capture("my name is (?<name>\\S+)"; "i")
  | "Nice to meet you, \(.name)";


# Given a string, perform very simple CSV parsing: fields are separated by a comman and optional whitespace
#
# input: {string} comma-separated row
# output: {array} fields
def parse_csv:
  # split/1 takes a string
  # split/2 takes a regex and flags
  split(",[[:blank:]]*"; "");
