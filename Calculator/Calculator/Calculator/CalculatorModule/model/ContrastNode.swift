//
//  SingleOpNode.swift
//  Calculator
//
//  Created by Nelson on 19/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class ContrastOpNode: OperatorNode {
    
    
    override func mergeWithNode(_ node:Node,
                                completeHandler:(Node)->(),
                                appendHandler:(Node)->(),
                                replaceHandler:(Node)->()) {
        
        //we dont accept number node
        //we absorb node
        if let _ = node as? NumberNode{
            completeHandler(self)
            return
        }
        
        //we dont accept decimal node
        //we absorb node
        if let _ = node as? DecimalNode{
            completeHandler(self)
            return
        }
        
        //operator node shoud be append
        appendHandler(node)
    }
    
    override func valueInString() -> String {
        
        return "+/-"
    }
    
    override func canAppend() -> Bool {
        
        return true
    }
    
    override func evaluate() -> NumberNode? {
        
        guard let leftHandNode = self.parentNode else{
            fatalError("Contrast node must have parent node")
        }
        
        if let numberNode = leftHandNode as? NumberNode{
            
            let result = NumberNode(numberNode.value.doubleValue() * -1.0)
            result.parentNode = leftHandNode.parentNode
            result.childNode = childNode
            
            leftHandNode.dropConnection()
            self.dropConnection()
            
            return result
        }
        
        fatalError("Contrast node's parent node is not a number node")
    }
    
    override func operatorType() -> OperatorType {
        return .SingleInput
    }
    
    override func operatorPriority() -> OperatorPriority {
        
        return .HighPriority
    }
}
