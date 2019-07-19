//
//  DecimalNode.swift
//  Calculator
//
//  Created by Nelson on 18/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class DecimalNode: Node {
    
    override func mergeWithNode(_ node: Node, completeHandler: (Bool, Node) -> ()) {
        
    }
    
    override func valueInString() -> String{
        return "."
    }
    
    override func canAppend() -> Bool {
        
        return false
    }
}
