//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Nelson on 17/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number : Double?
    private var intermediateCalculation : (n1 : Double, symbol : String)?
    
    let methods : [String : (Double)->Double] = [
        
        "+/-" : {(n) in return n * -1},
        "AC" : {(n) in return n * 0},
        "%" : {(n) in return n / 100}
    ]
    
    let operators : [String : (Double, Double)->Double] = [
        
        "+" : {(n1, n2) in return n1 + n2},
        "-" : {(n1, n2) in return n1 - n2},
        "x" : {(n1, n2) in return n1 * n2},
        "÷" : {(n1, n2) in return n1 / n2}
    ]
    
    mutating func setNumber(_ number:Double){
        self.number = number
    }
    
    mutating func calcuate(symbol : String) -> Double?{
        
        if let n = number{
            
            if let calMethod = methods[symbol]{
                return calMethod(n)
            }
            else if symbol == "="{
                
                return performCalculation(n2: n)
            }
            else{
                intermediateCalculation = (n1:n, symbol:symbol)
                return n
            }
        }
        
        
        return nil
    }
    
    func performCalculation(n2:Double)->Double{
        
        guard let interCalcuation = intermediateCalculation else{
            fatalError("operation have no left value")
        }
        
        guard let op = operators[interCalcuation.symbol] else{
            fatalError("operation symbol does not exist")
        }
        
        let n1 = interCalcuation.n1
        
        return op(n1, n2)
    }
}
