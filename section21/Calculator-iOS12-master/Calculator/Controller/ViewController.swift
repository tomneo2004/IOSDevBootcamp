//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber : Bool = true
    
    private var displayValue : Double {
        get{
            
            guard let retVal = Double(displayLabel.text!) else{
                fatalError("Can not convert \(displayLabel.text!) to Double")
            }
            
            return retVal
        }
        set{
            
            switch newValue {
            case let n where n > 0.0:
                displayLabel.text = floor(newValue) == newValue ? String(Int(floor(newValue))) : String(newValue)
                break
            case let n where n < 0.0:
                displayLabel.text = ceil(newValue) == newValue ? String(Int(ceil(newValue))) : String(newValue)
                break
            default:
                displayLabel.text = "0"
            }
            
//            if newValue != 0.00{
//                if newValue > 0.0
//                let isInt = floor(newValue) == newValue
//                displayLabel.text = String(newValue)
//            }
//            else{
//                displayLabel.text = "0"
//            }
        }
    }
    
    
    private var calculator = CalculatorLogic()
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        guard let result = calculator.calcuate(symbol: sender.currentTitle!) else{
            
            fatalError("Unable to calculate value")
        }
        
        displayValue = result
        
////////////////////unmanageable way////////////////////////////
//        if let calMethod = sender.currentTitle{
//
//            if calMethod == "+/-"{
//                displayLabel.text = String(number * -1)
//            }
//            else if calMethod == "AC"{
//                displayLabel.text = "0"
//            }
//            else if calMethod == "%"{
//                displayLabel.text = String(number / 100)
//            }
//        }
        
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let newValue = sender.currentTitle{
            if isFinishedTypingNumber{
                displayLabel.text = newValue
                isFinishedTypingNumber = false
            }
            else{
                
                if newValue == "."{
                    
                    let isInt = floor(displayValue) == displayValue && !displayLabel.text!.contains(".")
                    
                    if !isInt{
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + newValue
            }
        }
    }

}

