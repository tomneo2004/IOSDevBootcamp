//
//  __FILEBASENAME__.swift
//  
//
//  Created by Nelson on 13/7/19.
//

import Foundation

class CalculatorModel : NSObject, CalculatorControllerToModelProtocol{
    
    
    weak var MVC_Controller : CalculatorModelToControllerProtocol!
    
    override init() {
        let _ = Brain.sharedBrain
    }
    
    deinit {
        print("Model deinit")
    }
    
    func appendDigitalNumberWith(_ numberString: String, _ completeHandler: (Node) -> ()) {
        
        Brain.sharedBrain.inputNumberNode(NumberNode(Double(numberString)!)) { (result) in
            
        }
    }
    
    func appendDecimalSymbol(_ completeHandler: (Node) -> ()) {
        
        Brain.sharedBrain.inputDecimalNode(DecimalNode()) { (result) in
            
        }
    }
    
    func appendOperatorWith(_ operatorString: String, _ completeHandler: (Node) -> ()) {
        
    }
    
    func clearAll(_ completeHandler: (Node) -> ()) {
        
        Brain.sharedBrain.resetBrain { (result) in
            
        }
    }
    
    func calculateResult(_ completeHandler: (Node) -> ()) {
        
    }

}
