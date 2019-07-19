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
        
        tailNode = NumberNode(0)
        
    }
    
    func appendNode(_ newNode:Node, _ completeHandler:(Node)->()){
        
        tailNode?.mergeWithNode(newNode, completeHandler: { (result, node) in
            
            //if merge fail
            if !result{
                //TODO:append node
            }
            
            //merge successful
            print("\(node.valueInString())\n\((node as! NumberNode).value)")
        })
    }
    
    func resetBrain(_ completeHandler:(Node)->()){
        
    }
    
    func calculate(_ completeHandler:(Node)->()){
        
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
        
        //switch tail to new node
        tailNode = newNode
    }
}
