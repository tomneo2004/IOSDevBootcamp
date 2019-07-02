//
//  main.swift
//  Class and object
//
//  Created by Nelson on 2/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import Foundation

print("Hello, World!")

let car = Car()

print(car.color)
print(car.seats)
print(car.typeOfCar)

let myCar = Car(colorForCar: "Red")

print(myCar.color)
print(myCar.seats)
print(myCar.typeOfCar)

myCar.Drive()

let autoCar = SelfDriveCar()

autoCar.destination = "HQ"
autoCar.Drive()

