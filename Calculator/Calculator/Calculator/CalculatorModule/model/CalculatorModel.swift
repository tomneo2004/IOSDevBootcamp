//
//  __FILEBASENAME__.swift
//  
//
//  Created by Nelson on 13/7/19.
//

import Foundation

class CalculatorModel : NSObject, CalculatorControllerToModelProtocol{
    
    
    weak var MVC_Controller : CalculatorModelToControllerProtocol!
    
    deinit {
        print("Model deinit")
    }
    
    func appendDigitalNumberWith(_ numberString: String, _ completeHandler: (Double) -> ()) {
        
    }
    
    func appendDecimalSymbol(_ completeHandler: (Double) -> ()) {
        
    }
    
    func appendOperatorWith(_ operatorString: String, _ completeHandler: (Double) -> ()) {
        
    }
    
    func clearAll(_ completeHandler: (Double) -> ()) {
        
    }
    
    func calculateResult(_ completeHandler: (Double) -> ()) {
        
    }

}
