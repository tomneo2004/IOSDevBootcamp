import UIKit

var pizzaInInch : Int = 11{
    willSet{
        print(newValue)
    }
    didSet{
        print(oldValue)
        if pizzaInInch > 20{
            pizzaInInch = 20
        }
    }
}

pizzaInInch = 44
print(pizzaInInch)

var numberOfSlices : Int{
    get{
        return pizzaInInch - 4
    }
    set{
        print(newValue)
    }
}

var numberOfPeople : Int = 12
var slicePerPerson : Int = 4

var numberOfPizza : Int{
    get{
        let numberOfPeopleFedPerPizza = numberOfSlices / slicePerPerson
        return numberOfPeople / numberOfPeopleFedPerPizza
    }
    set{
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices / slicePerPerson
    }
}


numberOfPizza = 4

print(numberOfPizza)

var width : Float = 1.5
var height : Float = 2.3

var numberOfBuckets : Int{
    get{
        let total = width * height
        return Int(ceilf(total / 1.5))
    }
    set{
        print(Float(newValue) * 1.5)
    }
}

numberOfBuckets = 4
print(numberOfBuckets)


