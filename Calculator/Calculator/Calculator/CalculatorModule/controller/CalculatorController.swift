//
//  __FILEBASENAME__.swift
//  
//
//  Created by Nelson on 13/7/19.
//

import Foundation

class CalculatorController : NSObject, CalculatorViewToControllerProtocol, CalculatorModelToControllerProtocol{

    
    
    weak var MVC_View : CalculatorControllerToViewProtocol!
    var MVC_Model : CalculatorControllerToModelProtocol!
    
    deinit {
        print("Controller deinit")
    }
    
    func onDigitalNumberPress(_ digitString: String) {
        
        //tell model to append a number
        MVC_Model.appendDigitalNumberWith(digitString) { (numberString) in
            
            //TODO:tell view update UI with result
            MVC_View.updateCalculatorDisplay(result: numberString)
        }
    }
    
    func onDecimalPress() {
        
        //tell model to append a decimal
        MVC_Model.appendDecimalSymbol { (numberString) in
            
            //TODO:tell view update UI with result
            MVC_View.updateCalculatorDisplay(result: numberString)
        }
    }
    
    func onOperatorPress(_ operatorString: String) {
        
        //tell model to append a operator
        
        MVC_Model.appendOperatorWith(operatorString) { (numberString) in
            
            //TODO:tell view update UI with result
            MVC_View.updateCalculatorDisplay(result: numberString)
        }
    }
    
    func onClearPress() {
        
        //tell model to clear all
        MVC_Model.clearAll { (numberString) in
            
            //TODO:tell view update UI with result
            MVC_View.updateCalculatorDisplay(result: numberString)
        }
    }
    
    func onCalculatePress() {
        
        //tell model to calculate
        MVC_Model.calculateResult { (numberString) in
            
            //TODO:tell view update UI with result
            MVC_View.updateCalculatorDisplay(result: numberString)
        }
    }
}
