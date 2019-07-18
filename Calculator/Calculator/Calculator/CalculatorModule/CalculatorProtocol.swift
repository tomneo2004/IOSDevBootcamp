//
//  __FILEBASENAME__.swift
//  
//
//  Created by Nelson on 13/7/19.
//

import Foundation

protocol CalculatorViewToControllerProtocol : class{
    
    ///when user press digital button
    func onDigitalNumberPress(_ numberString:String)
    
    //when user press decimal button
    func onDecimalPress()
    
    //when user press operator button
    func onOperatorPress(_ operatorString:String)
    
    //when user press clear button
    func onClearPress()
    
    //when user press calculate button
    func onCalculatePress()
}

protocol CalculatorControllerToViewProtocol : class{
    
}

protocol CalculatorControllerToModelProtocol : class{
    
    func appendDigitalNumberWith(_ numberString:String, _ completeHandler:(Double)->())
    
    func appendDecimalSymbol(_ completeHandler:(Double)->())
    
    func appendOperatorWith(_ operatorString:String, _ completeHandler:(Double)->())
    
    func clearAll(_ completeHandler:(Double)->())
    
    func calculateResult(_ completeHandler:(Double)->())
}

protocol CalculatorModelToControllerProtocol : class{
    
}
