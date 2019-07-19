//
//  OperatorNode.swift
//  Calculator
//
//  Created by Nelson on 19/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

enum OperatorType{
    case SingleInput
    case DoubleInput
}

enum OperatorPriority : Int{
    case LowPriority = 0
    case MediumPriority = 1
    case HighPriority = 2
}

protocol OperatorNodeProtocol {
    
    func evaluate() -> NumberNode?
    func operatorType() -> OperatorType
    func operatorPriority() -> OperatorPriority
}

class OperatorNode : Node, OperatorNodeProtocol{
    
    func evaluate() -> NumberNode? {
        
        fatalError("Subclass must override this method")
    }
    
    func operatorType() -> OperatorType {
        
        fatalError("Subclass must override this method")
    }
    
    func operatorPriority() -> OperatorPriority {
        
        fatalError("Subclass must override this method")
    }
    
    
}
