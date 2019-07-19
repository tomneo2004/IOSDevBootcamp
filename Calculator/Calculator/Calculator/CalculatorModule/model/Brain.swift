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
            print("\(selfNode.valueInString())\n\((selfNode as! NumberNode).value)")
            
        }, appendHandler: { (node) in
            
        }, replaceHandler: { (node) in
            
        })
        
    }
    
    func inputDecimalNode(_ newNode:DecimalNode, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (selfNode) in
            
            //merge successful
            print("\(selfNode.valueInString())\n\((selfNode as! NumberNode).value)")
            
        }, appendHandler: { (node) in
            
        }, replaceHandler: { (node) in
            
        })    }
    
    func inputOperatorNode(_ newNode:OperatorNode, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (selfNode) in
            
            
        }, appendHandler: { (node) in
            
        }, replaceHandler: { (node) in
            
        })
    }
    
    func resetBrain(_ completeHandler:(Node)->()){
        
        guard let tail = tailNode else{
            
            reset()
            return
        }
        
        var preNode = tail.parentNode
        
        while(preNode != nil){
            
            tail.dropConnection()
            tailNode = preNode
            preNode = tailNode?.parentNode
        }
        
        reset()
        
        completeHandler(tailNode!)
        
        print("Brain reset \(tailNode!.valueInString())")
    }
    
    func calculate(_ completeHandler:(Node)->()){
        
    }
    
    
    ///reset brain to initial state
    private func reset(){
        
        tailNode = NumberNode(0)
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
