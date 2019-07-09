import UIKit

class Car{
    var color = "Red"
    
    //create Car object as singleton
    static let singletonCar = Car()
}

var mySingletonCar = Car.singletonCar
var yourSingletonCar = Car.singletonCar

let myCar = Car()
let yourCar = Car()


/**************************************************************************
 What a phyiscal memory look like, it look like a block on top of each other.
 Remember object was created and stored in memory block totally individual and unique.
 Memory block can stored created object or memory address. You use computer programming
 language to instruct computer to open an memory or store object in memory for you
 
 ------------
 |  0x0002  | <- memory address 0x0001
 ------------
 ------------
 |Car object| <- memory address 0x0002
 ------------
 ------------
 |  0x0004  | <- memory address 0x0003
 ------------
 ------------
 |Car object| <- memory address 0x0004
 ------------
 ------------
 |          | <- memory address 0x0005
 ------------
 ------------
 |          | <- memory address 0x0006
 ------------
 
 **************************************************************************/

/**************************************************************************
 Class is always reference
 
 When you declare a variable either use let or var you tell computer to open an empty space in physical memory for you and that space has it's own address, it may looks like this 0x0001fc32. Once you decalare that variable it is empty and waiting to be filled. Let's say "let myCar" then computer open an empty space in physical memory and it's memory address is 0x0001
 
 Now When you do Car() you tell computer to create Car object and then open an empty space in physical memory for you, in adittion, computer will automatically store Car object into that empty space in physical memory. Let's say Car() create Car object and open an empty space in physical memory then computer automatically store Car object into that space and it's memory address is 0x0002
 
 At this point you have told computer open space 0x0001(empty) and anthor space 0x0002(Car object). When you put an equal sign between them as you see let myCar = Car() you tell computer say hey make 0x0001 = 0x0002(or 0x0001 store address 0x0002). Therefore myCar(0x0001) has hold a reference to 0x0002 which has real Car object stored.
 
 If you are confuse, take look at memory block picture.
 
 So it might be look like this for "Not Singleton":
 
 let myCar = Car()    -----> 0x0001 = 0x0002(Car object)
 let yourCar = Car()  -----> 0x0003 = 0x0004(Car object)
 
 If you change color on either of them them will not effect each other. Why? beause myCar.color = "Blue" like you are saying 0x0002.color = "Blue" remember 0x0001 = 0x0002. Same thing go with yourCar 0x0003 = 0x0004. You change color on different individule Car object.
 
 When you do myCar.color = "yellow" ----> myCar(0x0001)   .(dot mean find real object in memory) color(property in object) = "yellow"
 
 
 As "Singleton":
 
 static let singletonCar = Car() ----> 0x0005 = 0x0006(Car object)
 var mySingletonCar = Car.singletonCar ----> 0x0007 = 0x0005    you say 0x0007 has 0x0005 which has Car object stored in it
 var yourSingletonCar = Car.singletonCar ---->0x0008 = 0x0005   you say 0x0008 has 0x0005 which has Car object stored in it
 
 If you change color on either of them mySingletonCar or yourSingletonCar you change 0x0006 Car object. The same one Car object
 
 **************************************************************************/
