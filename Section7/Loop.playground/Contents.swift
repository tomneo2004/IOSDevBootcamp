import UIKit

//from 1 ~ 10
for number in 1...10{
    
    print(number)
}

//from 1 ~ 9
for number in 1..<10{
    
    print(number)
}

//only even number
for number in 1...10 where number % 2 == 0{
    
    print(number)
}

//func beerSong(_ numberOfBottles : Int) get rid of external parameter with _
func beerSong(withThisManyBottles numberOfBottles : Int){
    
    if(numberOfBottles <= 0){
        print("No song to be sing");
    }
    else{
        
        for number in (1...numberOfBottles).reversed(){
            
            print("\(number) bottles of beer on wall. \(number) bottles of beer. \n Take it down pass it around\((number-1) > 0 ? ", \(number-1) bottles of beer on wall\n" : "\n")")
        }
        
        print("No more bottles of beer on wall. No more bottles of beer.")
    }

}

beerSong(withThisManyBottles: 200)


