import UIKit

func getMilk(){
    print("Get Milk")
}

//Return change after buying milk
func getNumberMilk(num : Int, money : Int) -> Int{
    
    print("buy \(num) milk with money \(money)")
    
    let totalPrice = num * 30
    var change = 0
    
    if(money >= totalPrice){
        change = money - totalPrice
    }
    else{
        print("Not enough money to buy milk")
    }
    
    return change
}

getMilk()
getNumberMilk(num: 3, money: 2000)
getNumberMilk(num: 3, money: 1)
