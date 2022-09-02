#!/usr/bin/env bats
load bats-extra

setup() {
    cat > input.json <<'END_JSON'
{
  "name": "Ingredients for pancakes",
  "ingredients": [
    {
      "item": "flour",
      "amount": {
        "quantity": 1,
        "unit": "cup"
      }
    },
    {
      "item": "sugar",
      "amount": {
        "quantity": 0.25,
        "unit": "cup"
      }
    },
    {
      "item": "baking powder",
      "amount": {
        "quantity": 1,
        "unit": "teaspoon"
      }
    },
    {
      "item": "baking soda",
      "amount": {
        "quantity": 0.25,
        "unit": "teaspoon"
      }
    },
    {
      "item": "salt",
      "amount": {
        "quantity": 1,
        "unit": "pinch"
      }
    },
    {
      "item": "buttermilk",
      "amount": {
        "quantity": 1,
        "unit": "cup"
      },
      "substitute": "regular milk"
    },
    {
      "item": "eggs",
      "amount": {
        "quantity": 1,
        "unit": "egg"
      }
    },
    {
      "item": "melted butter",
      "amount": {
        "quantity": 1,
        "unit": "tablespoon"
      },
      "substitute": "vegetable oil"
    }
  ],
  "optional ingredients": [
    {
      "item": "cinnamon",
      "amount": {
        "quantity": 0.25,
        "unit": "teaspoon"
      }
    },
    {
      "item": "vanilla extract",
      "amount": {
        "quantity": 0.5,
        "unit": "teaspoon"
      }
    },
    {
      "item": "blueberries",
      "amount": {
        "quantity": 0.25,
        "unit": "cup"
      },
      "substitute": "chopped apple"
    }
  ]
}
END_JSON

}

teardown() {
    rm input.json
}

@test "Show exercise name" {
    ## task 1
    run jq -f shopping.jq input.json
    assert_success
    assert_line --index 0 '"two-fer"'
}

@test "Show the description of the first case" {
    ## task 2
    run jq -f shopping.jq input.json
    assert_success
    assert_line --index 1 '"no name given"'
}

@test "Show the input name of the last case" {
    ## task 3
    run jq -f shopping.jq input.json
    assert_success
    assert_line --index 2 '"Bob"'
}

@test "Count the number of cases" {
    ## task 4
    run jq -f shopping.jq input.json
    assert_success
    assert_line --index 3 '3'
}

@test "Show all the cases have property 'twoFer'" {
    ## task 5
    run jq -f shopping.jq input.json
    assert_success
    assert_line --index 4 'true'
}
