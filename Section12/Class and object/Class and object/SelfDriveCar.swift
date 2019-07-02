//
//  SelfDriveCar.swift
//  Class and object
//
//  Created by Nelson on 2/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import Foundation

class SelfDriveCar : Car{
    
    var destination : String?
    
    override func Drive() {
        
        if let dest = self.destination{
            print("Self drive to \(dest)")
        }
        

    }
    
}
