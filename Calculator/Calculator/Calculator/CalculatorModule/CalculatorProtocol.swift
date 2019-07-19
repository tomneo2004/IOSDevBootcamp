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
    
    ///append a digital number
    func appendDigitalNumberWith(_ numberString:String, _ completeHandler:(Node)->())
    
    ///append a decimal to digital
    func appendDecimalSymbol(_ completeHandler:(Node)->())
    
    ///append a operator
    func appendOperatorWith(_ operatorString:String, _ completeHandler:(Node)->())
    
    ///clear all
    func clearAll(_ completeHandler:(Node)->())
    
    ///calculate final result
    func calculateResult(_ completeHandler:(Node)->())
}

protocol CalculatorModelToControllerProtocol : class{
    
}
