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
    
    func onDigitalNumberPress(_ numberString: String) {
        
        //tell model to append a number
        MVC_Model.appendDigitalNumberWith(numberString) { (node) in
            
            //TODO:tell view update UI with result
        }
    }
    
    func onDecimalPress() {
        
        //tell model to append a decimal
        MVC_Model.appendDecimalSymbol { (node) in
            
            //TODO:tell view update UI with result
        }
    }
    
    func onOperatorPress(_ operatorString: String) {
        
        //tell model to append a operator
        
        MVC_Model.appendOperatorWith(operatorString) { (node) in
            
            //TODO:tell view update UI with result
        }
    }
    
    func onClearPress() {
        
        //tell model to clear all
        MVC_Model.clearAll { (node) in
            
            //TODO:tell view update UI with result
        }
    }
    
    func onCalculatePress() {
        
        //tell model to calculate
        MVC_Model.calculateResult { (node) in
            
            //TODO:tell view update UI with result
        }
    }
}
