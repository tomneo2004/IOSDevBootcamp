//
//  Node.swift
//  Calculator
//
//  Created by Nelson on 18/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

protocol NodeProtocol {
    
    ///merge this node with different node
    ///
    ///return true and a node which you call on when merge successful
    ///
    ///return false and a node you give as parameter when merge fail
    func mergeWithNode(_ node:Node,
                       completeHandler:(Node)->(),
                       appendHandler:(Node)->(),
                       replaceHandler:(Node)->())
    
    ///return value of node in string
    func valueInString() -> String
    
    ///can this node be append
    func canAppend() -> Bool
}

class Node : NodeProtocol{
    
    
    var parentNode : Node?
    var childNode : Node?
    
    deinit {
        print("node removed")
    }
    
    ///remove node's parent and child
    func dropConnection(){
        
        parentNode = nil
        childNode = nil
    }
    
    func mergeWithNode(_ node:Node,
                       completeHandler:(Node)->(),
                       appendHandler:(Node)->(),
                       replaceHandler:(Node)->()) {
        
        fatalError("Subclass must override this method")
    }
    
    func valueInString() -> String {
        
        fatalError("Subclass must override this method")
    }
    
    func canAppend() -> Bool {
        
        fatalError("Subclass must override this method")
    }
}
