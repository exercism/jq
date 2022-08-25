1000000000 as $Gigasecond
| .moment as $dt
| try ($dt + "Z" | fromdateiso8601)
  catch ($dt + "T00:00:00Z" | fromdateiso8601)
| . + $Gigasecond
| strftime("%FT%T")
