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
    
    func appendNode(_ newNode:Node, _ completeHandler:(Node)->()){
        
        //try to merge node first, if it fail then try to append node
        //to list
        tailNode?.mergeWithNode(newNode, completeHandler: { (result, node) in
            
            //if merge fail then try append node
            if !result{
                //append node
                if node.canAppend(){
                    
                    appendNodeToTailNode(node)
                }
                
            }
            
            //merge successful
            print("\(node.valueInString())\n\((node as! NumberNode).value)")
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
