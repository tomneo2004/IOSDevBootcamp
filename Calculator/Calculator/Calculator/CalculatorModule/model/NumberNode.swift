//
//  NumberNode.swift
//  Calculator
//
//  Created by Nelson on 18/7/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class NumberNode: Node {
    
    ///Return a value in decimal
    var value : Decimal{
        get{
            return Decimal(wholeNumber) + fractionNumber
        }
    }
    
    private var valueSign : Double{
        get{
            return value < 0.0 ? -1.0 : 1.0
        }
    }
    
    ///is number a decimal or integer
    private var isDecimal : Bool = false
    
    ///return value in string for display
    private var displayableValue : String{
        get{
            //nagetive sign or positive
            var result = wholeNumber < 0 || fractionNumber < 0.0 ? "-" : ""
            
            result += String(wholeNumber.magnitude)
            
            //if number is decimal
            if isDecimal{
                result += "."
                
                //if we have fraction number
                if fractionOffset > 0{
                    
                    //extract fraction part where is after decimal
                    let absFractionNumber = fractionNumber.magnitude
                    let fractions = "\(absFractionNumber)".split(separator: ".")
                    var fractionStr = fractions.count > 1 ? fractions[1] : ""
                    
                    //how long is fraction part
                    let fractionLength = fractionStr.count
                    
                    //find number of empty space between fractionOffset
                    //and fraction current length
                    let count = fractionOffset - fractionLength
                    
                    //try to fill 0 between fractionOfsset and fraction current length
                    //As value 123.189 and fraction offset after decimal is 5 then
                    //it should be display as 123.18900
                    if count > 0{
                        for _ in 1...count{
                            fractionStr += "0"
                        }
                    }
                    
                    result += fractionStr
                }
                
            }
            
            return result
        }
    }
    
    ///hold part of whole number
    private var wholeNumber : Int = 0
    
    ///offset of whole number e.g 123 offset is 3
    ///if whole number is 0 offset will be 0
    private var wholeOffset : Int = 0
    
    ///hold part of fraction number
    ///use decmial to be more precise
    private var fractionNumber : Decimal = Decimal.zero
    
    ///offset of fraction number e.g 0.0123 offset is 4
    ///if fraction number is 0.0 offset will be 0
    private var fractionOffset : Int = 0
    
    ///max digitals this number can hold
    private let maxDigitals = 16
    
    
    //MAKR: - init
    convenience init(_ inValue : Double) {
        self.init()
        
        //sign
        let sign = inValue < 0.0 ? -1 : 1
        
        //get absolute value
        let absValue = inValue.magnitude
        
        //is value an integer
        let isInt = floor(absValue) == absValue
        
        wholeNumber = Int(floor(absValue))
        
        //if whole number is not 0 then find out wholeOffset
        if wholeNumber != 0{
            
            //whole offset
            //use log base of 10 with whole number to get number of times
            //10 should multiply itself to reach or close to whole number
            //floor down number
            //Example 123456 after log base of 10 will be 5
            //because it is 6 digitals so shuold plus 1
            wholeOffset = Int( floor((log(Double(wholeNumber)))) )+1
        }
        else{
            wholeOffset = 0
        }
        
        //if number is Integer
        if isInt{
            
            fractionNumber = Decimal.zero
            fractionOffset = 0
            isDecimal = false
        }
        else{// it is decimal
            
            fractionNumber = Decimal(absValue - Double(wholeNumber))
            
            //find out fraction offset
            let fractionLength = "\(fractionNumber)".split(separator: ".")[1].count
            fractionOffset = fractionLength
            isDecimal = true
        }
        
        //apply sign
        wholeNumber *= sign
        fractionNumber  = fractionNumber * Decimal(Double(sign))
        
    }
    
    //MARK: - override from parent
    override func mergeWithNode(_ node:Node,
                                completeHandler:(Node)->(),
                                appendHandler:(Node)->(),
                                replaceHandler:(Node)->()) {
        
        
        //merge with number node
        if let numberNode = node as? NumberNode{
            
            //if digitals over or equal max
            //dot not allow more digitals
            if wholeOffset + fractionOffset >= maxDigitals{
                completeHandler(self)
                return
            }
            
            //if this number is not a decimal
            //we deal with whole number
            if !isDecimal{
                
                var newWholeNumber = wholeNumber
                let absWholeNumber = wholeNumber.magnitude
                wholeOffset += 1
                newWholeNumber = Int(absWholeNumber * 10 + UInt(numberNode.value.doubleValue()))
                
                wholeNumber = newWholeNumber * Int(valueSign)
            }
            else{ //if this number's value is decimal
                
                fractionOffset += 1
                var newFractionNumber = fractionNumber
                let absFractionNumber = fractionNumber.magnitude
                let newFraction = numberNode.value / pow(Decimal(10.0), fractionOffset)
                newFractionNumber  = absFractionNumber + newFraction
                
                fractionNumber = newFractionNumber * Decimal(valueSign)
            }
            
            completeHandler(self)
            
            print("current digits \(wholeOffset + fractionOffset) of \(maxDigitals)")
            
            return
        }
        
        //merge with decimal node
        if let _ = node as? DecimalNode{
            
            //was no decimal
            if !isDecimal{
                isDecimal = true
                fractionOffset = 0
                
            }
            
            completeHandler(self)
            return
        }
        
        //when other node can not be merged
        //we notify to append
        appendHandler(node)
    }
    
    override func valueInString() -> String{
        
        return displayableValue
    }
    
    override func canAppend() -> Bool {
        
        return true
    }
}


//MARK: - extension to Decimal
extension Decimal{
    
    ///extension to decimal to return double value
    func doubleValue()->Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
