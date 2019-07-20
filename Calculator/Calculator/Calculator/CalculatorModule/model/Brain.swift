//
//  Brain.swift
//  Calculator
//
//  Created by Nelson on 18/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Brain {
    
    static let sharedBrain : Brain = Brain()
    
    private var tailNode : Node?
    
    init() {
        
        reset()
    }
    
    func inputNumberNode(_ newNode:NumberNode, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (selfNode) in
            
            //merge successful
            logAllNodes()
            
        }, appendHandler: { (node) in
            
            appendNodeToTailNode(node)
            
            logAllNodes()
            
        }, replaceHandler: { (node) in
          
            replaceTailNodeWithNode(node)
        })
        
    }
    
    func inputDecimalNode(_ newNode:DecimalNode, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (selfNode) in
            
            //merge successful
            logAllNodes()
            
        }, appendHandler: { (node) in
            
            //DecimalNode should not be append to list
            
        }, replaceHandler: { (node) in
            
            //DecimalNode should not replace any node in list
        })
        
    }
    
    func inputOperatorNode(_ newNode:OperatorNode, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (selfNode) in
            
            
        }, appendHandler: { (node) in
            
            appendNodeToTailNode(node)
            
            //this should not be called just a test
            guard let opNode = tailNode as? OperatorNode else{
                fatalError("append operator node at tail but tail is not operator node")
            }
            
            evaluateNodesWithPriority(opNode.operatorPriority())

        }, replaceHandler: { (node) in
            
            replaceTailNodeWithNode(node)
            
            //this should not be called just a test
            guard let opNode = tailNode as? OperatorNode else{
                fatalError("append operator node at tail but tail is not operator node")
            }
            
            evaluateNodesWithPriority(opNode.operatorPriority())
        })
    }
    
    func resetBrain(_ completeHandler:(Node)->()){
        
        guard let tail = tailNode else{
            
            reset()
            return
        }
        
        var preNode = tail.parentNode
        
        //disconnect all nodes
        while(preNode != nil){
            
            tail.dropConnection()
            tailNode = preNode
            preNode = tailNode?.parentNode
        }
        
        reset()
        
        completeHandler(tailNode!)
        
        print("Brain reset \(tailNode!.valueInString())")
    }
    
    ///Call this when new operator append
    private func evaluateNodesWithPriority(_ priority:OperatorPriority){
        
        guard let tail = tailNode else{
           return
        }
        
        print("\nbefore evaluation")
        logAllNodes()
        
        var nextOpNode : OperatorNode? = nil
        
        if let opNode = tailNode as? OperatorNode{
            nextOpNode = opNode
        }
        else{
            nextOpNode = findNextOperatorNodeFrom(tailNode!)
        }
        
        while(nextOpNode != nil){
            
            //if priority is lower then find next operator
            if nextOpNode!.operatorPriority().rawValue < priority.rawValue{
                
                nextOpNode = findNextOperatorNodeFrom(nextOpNode!)
                
                continue
            }
            
            var pointToResult = false
            
            if nextOpNode?.parentNode === tailNode!{
                pointToResult = true
            }
            else if nextOpNode?.childNode === tailNode{
                pointToResult = true
            }
            
            //if evaluate successful
            if let numberNode = nextOpNode?.evaluate(){
                
                if tail === nextOpNode || pointToResult{
                    tailNode = numberNode
                }
                
                nextOpNode = findNextOperatorNodeFrom(numberNode)
                continue
            }
            
            nextOpNode = findNextOperatorNodeFrom(nextOpNode!)
        }
        
        print("\nafter evaluation:")
        logAllNodes()
    }
    
    ///find nearest operator node from given node
    ///traverse back to parent
    private func findNextOperatorNodeFrom(_ node:Node) -> OperatorNode?{
        
        var nextNode : Node? = node.parentNode
        
        while(nextNode != nil){
            
            if let opNode = nextNode as? OperatorNode{
                return opNode
            }
            
            nextNode = nextNode?.parentNode
        }
        
        return nil
    }
    
    func findLastNumberNode() -> NumberNode?{
        
        if let tail = tailNode{
            
            var nextNode : Node? = tail
            
            while(nextNode != nil){
                if let numberNode = nextNode as? NumberNode{
                    return numberNode
                }
                nextNode = nextNode?.parentNode
            }
        }
        
        return nil
    }
    
    func calculate(_ completeHandler:(Node)->()){
        
        if let opNode = tailNode as? OperatorNode{
            
            //if tail node is double input operator
            if opNode.operatorType() == .DoubleInput{
                
                //get last number node
                guard let lastNumberNode = findLastNumberNode() else{
                    fatalError("No NumberNode in operation sentence")
                }
                
                //create new number node with last number node's value
                let newNumberNode = NumberNode(lastNumberNode.value)
                
                //append to tail node
                appendNodeToTailNode(newNumberNode)
            }
        }
        
        for priority in operatorPriorities{
            
            evaluateNodesWithPriority(priority)
        }
        
        logAllNodes()
    }
    
    
    ///reset brain to initial state
    private func reset(_ value : Decimal = Decimal.zero){
        
        tailNode = NumberNode(value)
    }
    
    private func logAllNodes(){
        
        guard let tail = tailNode else{
            
            fatalError("tail node is nil")
        }
        
        var nextNode : Node? = tail
        var log = ""
        while(nextNode != nil){
            log = " "+nextNode!.valueInString()+log
            nextNode = nextNode?.parentNode
        }
        
        print("Operation sentence: \(log)")
    }
    
    //conect tail node to new node and make tail node
    //point to new node
    private func appendNodeToTailNode(_ newNode:Node){
        
        if let tail = tailNode{
            
            if tail !== newNode{
                
                newNode.parentNode = tailNode
                tailNode?.childNode = newNode
                
                
            }
        }
        
        //point tail to new node
        tailNode = newNode
    }
    
    ///make brain's tail node point to new node
    private func replaceTailNodeWithNode(_ newNode:Node){
        
        //if tail node not nil
        if let tail = tailNode{
            
            //make sure tail node is not the same
            //object of new node by comparing with instance
            if tail !== newNode{
                
                //make new node parent and child point
                //to same node as tail node
                newNode.parentNode = tail.parentNode
                newNode.childNode = tail.childNode
                
                tail.dropConnection()
            }
            
        }
        
        //point tail to new node
        tailNode = newNode
    }
    
    func replaceNode(_ node:Node, _ withNode:Node, _ includeParent:Bool = false, _ includeChild:Bool = false){
        
        withNode.parentNode = nil
        withNode.childNode = nil
        
        var mostLeftNode : Node?
        var mostRightNode : Node?
        
        if includeParent{
            mostLeftNode = node.parentNode?.parentNode
            node.parentNode?.dropConnection()
        }
        else{
            mostLeftNode = node.parentNode
        }
        
        if includeChild{
            mostRightNode = node.childNode?.childNode
            node.childNode?.dropConnection()
        }
        else{
            mostRightNode = node.childNode
        }
        
        if mostLeftNode != nil{
            mostLeftNode?.childNode = withNode
            withNode.parentNode = mostLeftNode
        }
        
        if mostRightNode != nil{
            mostRightNode?.parentNode = withNode
            withNode.childNode = mostRightNode
        }
        
        node.dropConnection()
    }
    
    func removeNode(_ node:Node){
        
        let leftNode : Node? = node.parentNode
        let rightNode : Node? = node.childNode
        
        if leftNode != nil && rightNode != nil {
            leftNode?.childNode = rightNode
            rightNode?.parentNode = leftNode
        }
        else{
            leftNode?.childNode = nil
            rightNode?.parentNode = nil
        }
    }
}
