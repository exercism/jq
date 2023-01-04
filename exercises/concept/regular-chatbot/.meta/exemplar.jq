# Given a certain command, help the chatbot recognize whether the command is valid or not.
#
# input: {string} a command
# output: {boolean} whether or not is the command valid
#
def isValidCommand:
  test("^chatbot"; "i");

# Given a certain message, help the chatbot get rid of all the emoji's encryption throught the message.
#
# input: {string} message
# output: {string} The message without the emojis encryption
def removeEmoji:
  gsub("emoji[0-9]+"; "");

# Given a certain phone number, help the chatbot recognize whether it is in the correct format.
#
# @param {string} number
# @returns {string} the Chatbot response to the phone Validation
def checkPhoneNumber:
  "^\\(\\+?([0-9]{2})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{3})[-. ]?([0-9]{3})$" as $regex
  | if test($regex) then
      "Thanks! You can now download me to your phone."
    else
      "Oops, it seems like I can't reach out to \(.)"
    end;

#
#Given a certain response from the user, help the chatbot get only the URL
#
# @param {string} userInput
# @returns {string[] | null} all the possible URL's that the user may have answered
def getURL:
  scan("(?:\\w+\\.)+\\w+");

# Greet the user using its full name data from the profile
#
# @param {string} fullName
# @returns {string} Greeting from the chatbot
#
def niceToMeetYou:
  capture("my name is (?<name>\\S+)")
  | "Nice to meet you, \(.name)";
