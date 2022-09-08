.phrase
| ascii_upcase
| . / ""        # split into array of characters
| map(select("A" <= . and . <= "Z"))
| group_by(.)
| map(length == 1)
| all
