# Create a new score board with an initial entry.
#   input: none.
#   output: a score board object with a default player and score.
def create_score_board:
  "Please implement the create_score_board function" | halt_error;

# Add a player to a score board.
#   input: a score board object.
#   output: the score board with the new player added.
def add_player(player; score):
  "Please implement the add_player function" | halt_error;

# Remove a player from a score board.
#   input: a score board object.
#   output: the score board with the player removed, if they exist.
def remove_player(player):
  "Please implement the remove_player function" | halt_error;

# Increase a player's score by the given amount.
#   input: a score board object.
#   output: the score board with the player's score increased;
#           add the player to the board if needed.
def update_score(player; points):
  "Please implement the update_score function" | halt_error;

# Apply 100 bonus points to all players on the board.
#   input: a score board object.
#   output: the score board with each player's score increased.
def apply_monday_bonus:
  "Please implement the apply_monday_bonus function" | halt_error;

# Calculate the total score of all players.
#   input: a score board object.
#   output: the sum of all scores, or zero for an empty board.
def total_score:
  "Please implement the total_score function" | halt_error;
