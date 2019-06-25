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

func calculateBMI(weight : Double, heightInMeter : Double) -> String{
    
    let bmi = weight / (heightInMeter * heightInMeter)
    let shortBMI = String(format: "%.2f", bmi)
    var interp = ""
    if(bmi > 25){
       interp = "Overweight"
    }
    else if(bmi >= 18.5 && bmi <= 25){
        interp = "Normal weight"
    }
    else{
        interp = "Normal weight"
    }
    return "Your BMI is \(shortBMI) and you are \(interp)"
}

calculateBMI(weight: 78, heightInMeter: 1.78)

func calculateBMI(weightInPound : Double, heightInFeet : Double, remainderInch : Double){
    
    let weightInKg = weightInPound * 0.45359237
    let totalInch = heightInFeet * 12 + remainderInch
    let heightInM = totalInch * 0.0254
    
    var bmi = weightInKg / pow(heightInM, 2);
}

calculateBMI(weightInPound: 140, heightInFeet: 5, remainderInch:11)
