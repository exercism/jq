# Instructions

In this exercise, you are implementing a way to keep track of the high scores for the most popular game in your local arcade hall.

You have 6 functions to implement, mostly related to manipulating an object that holds high scores.

## 1. Create a new high score board

Write a function `create_score_board` which creates an object that serves as a high score board.
The keys of this object will be the names of the players, the values will be their scores.
For testing purposes, you want to directly include one entry in the object.
This initial entry should consist of `"The Best Ever"` as player name and `1000000` as score.

```jq
create_score_board
# returns an object with one initial entry
```

## 2. Add players to a score board

To add a player to the high score board, implement the function `add_player`.
It takes a score board as input, and needs two parameters: the player name and the player's score.
The function outputs the score board object with the new player added.

```jq
{"José Valim", 486373}
| add_player("Dave Thomas"; 0)
# => {"Dave Thomas": 0, "José Valim": 486373} -- in some order
```

## 3. Remove players from a score board

If players violate the rules of the arcade hall, they are manually removed from the high score board.
Implement `remove_player` which takes a board as input and one parameter, the name of the player to remove.
This function should remove the entry for the given player from the board and output the new board.
If the player was not on the board in the first place, nothing should happen to the board; it should be returned as is.

```q
{"Dave Thomas": 0} | remove_player("Dave Thomas")
# => {}

{"Dave Thomas": 0} | remove_player("Rose Fanaras")
# => {"Dave Thomas": 0}
```

## 4. Increase a player's score

If a player finishes another game at the arcade hall, a certain amount of points will be added to the previous score on the board.
Implement `update_score`, which takes a score board as input, and needs two parameters: the player name and the amount of score to add.
The function should return the score board after the update was done.

```jq
{"Freyja Ćirić": 12771000} | update_score("Freyja Ćirić"; 73)
# => {"Freyja Ćirić": 12771073}
```

## 5. Apply Monday bonus points

The arcade hall keeps a separate score board on Mondays.
At the end of the day, each player on that board gets 100 additional points.

Implement the function `apply_monday_bonus`.
The function adds the bonus points for each player that is listed on that board.

```jq
{
  "Dave Thomas": 44,
  "Freyja Ćirić": 539,
  "José Valim": 265
}
| apply_monday_bonus
# => {"Dave Thomas": 144, "Freyja Ćirić": 639, "José Valim": 365}
```

## 6. Find the total score

Different arcade halls compete with each other to determine who has the best players.
The arcade with the highest total score wins the honor.

Write a function `total_score`.
It takes a score board as input, and outputs the sum of all the players' scores.

```jq
{
  "Dave Thomas": 44,
  "Freyja Ćirić": 539,
  "José Valim": 265
}
| total_score
# => 848
```
