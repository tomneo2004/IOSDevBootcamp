//
//  Car.swift
//  Class and object
//
//  Created by Nelson on 2/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import Foundation


enum CarType{
    case Sedan
    case Coupe
    case Hatchback
}

class Car{
    
    internal var color : String = "Blue"
    var seats : Int = 5
    var typeOfCar : CarType = .Coupe
    
    init(){
        
    }
    
    convenience init(colorForCar : String){
        self.init()
        self.color = colorForCar
    }
    
    func Drive(){
        print("Drive")
    }
}

