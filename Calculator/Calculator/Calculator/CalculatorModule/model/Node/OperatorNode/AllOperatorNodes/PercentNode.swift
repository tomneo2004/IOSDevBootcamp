//
//  PercentNode.swift
//  Calculator
//
//  Created by Nelson on 20/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class PercentNode: OperatorNode {
    
    
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
        
        return "%"
    }
    
    override func canAppend() -> Bool {
        
        return true
    }
    
    override func evaluate() -> NumberNode? {
        
        guard let parent = self.parentNode else{
            fatalError("Percent node must have parent node")
        }
        
        if let leftHandeNode = parent as? NumberNode{
            
            let value = leftHandeNode.value / Decimal(sign: .plus, exponent: 2, significand: 1)
            
            let newNode = NumberNode(value)
            
            newNode.parentNode = leftHandeNode.parentNode
            newNode.childNode = self.childNode
            
            leftHandeNode.dropConnection()
            //drop our connection
            self.dropConnection()
            
            return newNode
        }
        
        fatalError("Invert node's parent node is not a number node")
    }
    
    override func operatorType() -> OperatorType {
        return .SingleInput
    }
    
    override func operatorPriority() -> OperatorPriority {
        
        return .HighPriority
    }
}
