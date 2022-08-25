#.value | split("") | reduce .[] as $char (""; $char + .)
.value | explode | reverse | implode
