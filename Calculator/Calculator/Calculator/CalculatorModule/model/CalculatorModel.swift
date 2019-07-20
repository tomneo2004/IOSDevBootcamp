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
    
    func appendDigitalNumberWith(_ numberString: String, _ completeHandler: (String) -> ()) {
        
        Brain.sharedBrain.inputNumberNode(NumberNode.NumberNodeFromString(numberString)) { (numberNode) in
            
            completeHandler(numberNode.valueInString())
        }
    }
    
    func appendDecimalSymbol(_ completeHandler: (String) -> ()) {
        
        Brain.sharedBrain.inputDecimalNode(DecimalNode()) { (numberNode) in
            
            completeHandler(numberNode.valueInString())
        }
    }
    
    func appendOperatorWith(_ operatorString: String, _ completeHandler: (String) -> ()) {
        
        let opType = operatorGroup[operatorString]
        
        guard let _ = opType else{
            fatalError("\(operatorString) not defined")
        }
        let opInstance : OperatorNode? = opType!.init()
        
        guard let newOperator = opInstance else{
            fatalError("create operator from \(operatorString) fail, operator probably not defined")
        }
        
        Brain.sharedBrain.inputOperatorNode(newOperator) { (numberNode) in
            
            completeHandler(numberNode.valueInString())
        }
    }
    
    func clearAll(_ completeHandler: (String) -> ()) {
        
        Brain.sharedBrain.resetBrain { (numberNode) in
            
            completeHandler(numberNode.valueInString())
        }
    }
    
    func calculateResult(_ completeHandler: (String) -> ()) {
        
        Brain.sharedBrain.calculate { (numberNode) in
            
            completeHandler(numberNode.valueInString())
        }
    }

}
