# Instructions

You have a sudden craving for pancakes.
As a modern technically-inclined person, you write a shopping list for pancake ingredients in JSON format.
The structure of the list is:

```json
{
  "name": "name of shopping list",
  "ingredients": [ ...list of ingredients... ],
  "optional ingredients": [ ...list of ingredients... ]
}
```

An ingredient is represented as a JSON object, like:

```json
  {
    "item": "flour",
    "amount": {
      "quantity": 2,
      "unit": "cup"
    }
  }
```
An ingredient has an optional property named `"substutite"` that holds a
string of another item that can be used instead.

Let's see how we can examine the shopping list with the `jq`

## 1. Extract the shopping list name

Write an expression that outputs the "name" element of the shopping list.

## 2. Count how many ingredients are needed

This is the "required" ingredients: don't include the optional ingredients.

## 3. How much sugar?

Write an expression that outputs the amount of sugar.
Just the numeric part is wanted.
