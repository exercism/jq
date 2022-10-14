# Instructions

In this exercise you'll be playing around with a remote controlled car, which you've finally saved enough money for to buy.

Cars start with full (100%) batteries. Each time you drive the car using the remote control, it covers 20 meters and drains one percent of the battery. The car's nickname is not known until it is created.

The remote controlled car has a fancy LED display that shows two bits of information:

- The total distance it has driven, displayed as: `"<METERS> meters"`.
- The remaining battery charge, displayed as: `"Battery at <PERCENTAGE>%"`.

If the battery is at 0%, you can't drive the car anymore and the battery display will show `"Battery empty"`.

## 1. Create a brand-new remote controlled car

Implement the `new_remote_control_car/0` function to return a brand-new remote controlled car object:

```jq
new_remote_control_car
# => {
#      "battery_percentage": 100,
#      "distance_driven_in_meters": 0,
#      "nickname": null
#    }
```

## 2. Create a brand-new remote controlled car with a nickname

Implement the `new_remote_control_car/1` function to return a brand-new remote controlled car object with a provided nickname:

```jq
new_remote_control_car("Blue")
# => {
#      "battery_percentage": 100,
#      "distance_driven_in_meters": 0,
#      "nickname": "Blue"
#    }
```

## 3. Display the distance

Implement the `display_distance/0` function that takes a car object as input and outputs the distance string as displayed on the LED display:

```jq
new_remote_control_car | display_distance
# => "0 meters"
```

## 4. Display the battery percentage

Implement the `display_battery/0` function that takes a car object as input and outputs the battery percentage string as displayed on the LED display:

```jq
new_remote_control_car | display_battery
# => "Battery at 100%"
```

If the battery is at 0%, the battery display will show "Battery empty".

## 5. Driving changes the battery and distance driven

Implement the `drive/0` function that:

- takes a car object as input
- updates the number of meters driven by 20
- drains 1% of the battery
- outputs the modified car object

```jq
new_remote_control_car("Red") | drive
# => {
#      "battery_percentage": 99,
#      "distance_driven_in_meters": 20,
#      "nickname": "Red"
#    }
```

## 6. Account for driving with a dead battery

Update the `drive/0` function to not increase the distance driven nor decrease the battery percentage when the battery is drained (at 0%):

```jq
{
  battery_percentage: 0,
  distance_driven_in_meters: 2000,
  nickname: "Tired Truck"
} | drive
# => {
#      "battery_percentage": 0,
#      "distance_driven_in_meters": 2000,
#      "nickname": "Tired Truck"
#    }
```
