//
//  __FILEBASENAME__.swift
//  
//
//  Created by Nelson on 13/7/19.
//

import Foundation

class CalculatorModel : NSObject, CalculatorControllerToModelProtocol{
    
    private let operatorGroup : [String:OperatorNode.Type] = [
        
        "+/-": InvertNode.self,
        "%": PercentNode.self,
        "+": AdditionNode.self,
        "-": SubtractNode.self,
        "×": MultiplyNode.self,
        "÷": DivisionNode.self
        
    ]
    
    
    weak var MVC_Controller : CalculatorModelToControllerProtocol!
    
    override init() {
        let _ = Brain.sharedBrain
    }
    
    deinit {
        print("Model deinit")
    }
    
    func appendDigitalNumberWith(_ numberString: String, _ completeHandler: (Node) -> ()) {
        
        Brain.sharedBrain.inputNumberNode(NumberNode.NumberNodeFromString(numberString)) { (result) in
            
        }
    }
    
    func appendDecimalSymbol(_ completeHandler: (Node) -> ()) {
        
        Brain.sharedBrain.inputDecimalNode(DecimalNode()) { (result) in
            
        }
    }
    
    func appendOperatorWith(_ operatorString: String, _ completeHandler: (Node) -> ()) {
        
        let opType = operatorGroup[operatorString]
        
        guard let _ = opType else{
            fatalError("\(operatorString) not defined")
        }
        let opInstance : OperatorNode? = opType!.init()
        
        guard let newOperator = opInstance else{
            fatalError("create operator from \(operatorString) fail, operator probably not defined")
        }
        
        Brain.sharedBrain.inputOperatorNode(newOperator) { (result) in
            
        }
    }
    
    func clearAll(_ completeHandler: (Node) -> ()) {
        
        Brain.sharedBrain.resetBrain { (result) in
            
        }
    }
    
    func calculateResult(_ completeHandler: (Node) -> ()) {
        
        Brain.sharedBrain.calculate { (node) in
            
        }
    }

}
