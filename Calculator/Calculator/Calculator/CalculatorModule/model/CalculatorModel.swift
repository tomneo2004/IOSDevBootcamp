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
}
