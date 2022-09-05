# Exercism jq track 

In progress ...

## TODOs

- concepts
- test runner

## Foregone exercises

| Exercise | Reason |
|---|---|
| grains | jq uses [IEEE 754 floats to represent numbers][numbers]: only 53 bits of precision |
| allergies | no bitwise operators |
| secret-handshake | no bitwise operators |
| variable-length-quantity | no bitwise operators |

bitwise operations: they [can be implemented][jbol-bitwise], but that's too much I think.
Unless we provide it as a library to include ...

[numbers]: https://github.com/stedolan/jq/wiki/FAQ#numbers 
[jbol-bitwise]: https://github.com/fadado/JBOL/blob/master/fadado.github.io/math/bitwise.jq
