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
        
        //TODO:tell model to append a number
        print("number press \(numberString)")
    }
    
    func onDecimalPress() {
        
        //TODO:tell model to append a decimal
        print("decimal press")
    }
    
    func onOperatorPress(_ operatorString: String) {
        
        //TODO:tell model to append a operator
        
        print("operator press \(operatorString)")
    }
    
    func onClearPress() {
        
        //TODO:tell model to clear all
        print("clear press")
    }
    
    func onCalculatePress() {
        
        //TODO:tell model to calculate
        print("calculate press")
    }
}
