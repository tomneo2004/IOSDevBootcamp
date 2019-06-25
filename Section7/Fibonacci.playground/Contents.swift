import UIKit

var str = "Hello, playground"

func fibonacci(until : Int){
    
    var num1 = 0
    var num2 = 1
    
    print(num1)
    print(num2)
    
    for i in 0...until{
        let num = num1 + num2
        print(num)
        num1 = num2
        num2 = num
        
    }
}

fibonacci(until: 20)
