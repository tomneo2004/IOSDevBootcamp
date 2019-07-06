import UIKit

func calcuator(num1:Int, num2:Int, handler:((Int, Int)->Int)?) ->Int?{
    
    //if handler is not nil then call handler
    return handler?(num1, num2)
}

var result = calcuator(num1: 1, num2: 2) { (n1, n2) -> Int in
    
    return n1 * n2;
}

var result2 = calcuator(num1: 2, num2: 2, handler: nil)

//if result is nil return 0
print(result ?? 0)
print(result2 ?? 0)

func calculator(n1 : Int, n2 : Int, operation : ((Int, Int) -> Int)?) -> Int{
    
    //if operation is not nil call operation closure otherwise it is nil return 0
    //? ---> variable on left hand is not nil
    //?? ---> variable on left hand is equal to nil then return right hand side value
    return operation?(n1, n2) ?? 0
}

var r = calculator(n1: 3, n2: 4, operation: nil)
print(r)//print 0 because operation is nil

var r2 = calculator(n1: 3, n2: 4){ return $0+$1}
print(r2)//print 7 when operation is provided


//Class A
class A{
    
    //hold a reference to closure
    //initilize an empty closure in empty closure "_" mean igonre pass in value
    var handler : (String)->Void = {_ in }
    
    //this method will be call when instance of A is about to be
    //removed from physical memory
    deinit {
        handler("A is about to be removed from memory")
    }
    
    //just a method with @escaping closure
    func doSomething(complete: @escaping (String)->Void){
        
        //we assign closure to handler property
        //because we will call closure later
        //but not now in this method
        //If you remove keyword @escaping
        //you will see error popup
        handler = complete
    }
    
}

//we create an instance of Class A
var a : A? = A()

//call doSomething method if variable a is not nil
//? ---> mean if variable a is not nil, short-hand version of
//if let
a?.doSomething { (message) in
    
    //print meesage
    print(message)
}

//we assgin nil to a variable
//so system will delete instance of Class A from memory
//this will make deinit() method been called.
a = nil
