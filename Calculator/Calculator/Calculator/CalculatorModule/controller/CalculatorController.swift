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
}
