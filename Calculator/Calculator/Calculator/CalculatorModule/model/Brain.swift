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
            print("valueInString:\(selfNode.valueInString())\nRealValue:\((selfNode as! NumberNode).value)")
            
        }, appendHandler: { (node) in
            
        }, replaceHandler: { (node) in
          
            replaceTailNodeWithNode(node)
        })
        
    }
    
    func inputDecimalNode(_ newNode:DecimalNode, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (selfNode) in
            
            //merge successful
            print("valueInString:\(selfNode.valueInString())\nRealValue:\((selfNode as! NumberNode).value)")
            
        }, appendHandler: { (node) in
            
        }, replaceHandler: { (node) in
            
            replaceTailNodeWithNode(node)
        })
        
    }
    
    func inputOperatorNode(_ newNode:OperatorNode, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (selfNode) in
            
            
        }, appendHandler: { (node) in
            
            appendNodeToTailNode(node)
            print("\nbefore evaluation")
            logAllNodes()
            guard let opNode = tailNode as? OperatorNode else{
                fatalError("append operator node at tail but tail is not operator node")
            }
            
            evaluateNodesWithPriority(opNode.operatorPriority())
            
            print("\nafter evaluation:")
            logAllNodes()
            
            
            
        }, replaceHandler: { (node) in
            
            replaceTailNodeWithNode(node)
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
        
        var nextOpNode = findNextOperatorNodeFrom(tail)
        
        while(nextOpNode != nil){
            
            //if priority is lower then find next operator
            if nextOpNode!.operatorPriority().rawValue < priority.rawValue{
                
                nextOpNode = findNextOperatorNodeFrom(nextOpNode!)
                
                continue
            }
            
            //if evaluate successful
            if let numberNode = nextOpNode?.evaluate(){
                
                if tail === nextOpNode{
                    tailNode = numberNode
                }
                
                nextOpNode = findNextOperatorNodeFrom(numberNode)
            }
            else{//evaluate fail
                
                fatalError("evaluate fail")
            }

        }
    }
    
    ///find nearest operator node from given node
    ///traverse back to parent
    private func findNextOperatorNodeFrom(_ node:Node) -> OperatorNode?{
        
        var nextNode : Node? = node
        
        while(nextNode != nil){
            
            if let opNode = nextNode as? OperatorNode{
                return opNode
            }
            
            nextNode = nextNode?.parentNode
        }
        
        return nil
    }
    
    func calculate(_ completeHandler:(Node)->()){
        
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
}
