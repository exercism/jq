.phrase
| [ scan("[[:alpha:]][[:alpha:]']*") ]  # find all the words
| map(.[0:1])                           # first character
| add                                   # concatenate
| ascii_upcase
