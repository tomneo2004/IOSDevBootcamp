import UIKit

/******************************************************************************************
 Inheritence
 
 My family's problem
 ******************************************************************************************/

/*****
 Inheritence is a way to allow
 an object to inherite properties
 and functionalities from it's
 parent class.
 *****/

/******
 Problem without inheritence
 
 Below is my family version 1 blueprint
 ******/


class GrandFather_V1{
    var walkSpeed = 10
    
    func walk(){
        print("Grand father version 1 walking at speed \(walkSpeed)")
    }
}


class MyParent_V1{
    var walkSpeed = 20
    
    func walk(){
        print("My parent version 1 walking at speed \(walkSpeed)")
    }
}


class Me_V1{
    var walkSpeed = 30
    
    func walk(){
        print("Me version 1 walking at speed \(walkSpeed)")
    }
}

/**********
 Let's test it
 **********/
//I create my grand fater version 1 object
let grandFaterV1 = GrandFather_V1()
//I create my parent version 1 object
let myParentV1 = MyParent_V1()
//I create myself version 1 object
let meV1 = Me_V1()
//Grand father version 1 can walk
grandFaterV1.walk()
//My parent version 1 can walk
myParentV1.walk()
//Myself version 1 can walk
meV1.walk()

print("*******************************************************************************************************************\n\n\n")

/**********
 It seems no problem at all.
 But have you awared of problem?
 
 As long as, my grand father have a new property,
 my parent and me have to declare a new property which
 is as same name as grand father. This problem happen
 to method in class as well. As long as, my grand father
 have a new method then my parent and my have to declare a
 new method which is as same name as grand father.
 
 This is a tedious work and even copy and past is not
 going to save you.
 
 We need a solution which is Inheritence.
 **********/

 /**********
 Inheritence
 
 The idea of inheritence is to let parent class to have
 all possible properties and methods that can be inherited
 by children class. In addtion, children class can override
 parent class's method to create their own version
 **********/

/**********
 Now let use inheritence to solve problem
 
 My family have evolved to version 2
 **********/


class GrandFather_V2{
    var walkSpeed = 10
    
    func walk(){
        print("Grand father version 2 walking at speed \(walkSpeed)")
    }
}

class MyParent_V2:GrandFather_V2{
    //We don't need to declare walkSpeed properties
    //Instead we inherite from grand father
    
    //We just need to override method from parent class
    override func walk(){
        //We evolve to much faster at walking
        self.walkSpeed = 20
        print("My parent version 2 walking at speed \(walkSpeed)")
    }
}

class Me_V2:MyParent_V2{
    //We don't need to declare walkSpeed properties
    //Instead we inherite from my parent
    
    //We just need to override method from parent class
    override func walk() {
        //I walk even faster than my parent at walking
        self.walkSpeed = 30
        print("Me version 2 walking at speed \(walkSpeed)")
    }
}

class MySon:Me_V2{
    
    //Even my son have nothing in blueprint
    //My son inherite property walkSpeed
    //My son inherite walk method
}

/**********
 Let's test it
 **********/
//my grand fater version 2 object
let grandFaterV2 = GrandFather_V2()
//my parent version 2 object
let myParentV2 = MyParent_V2()
//myself version 2 object
let meV2 = Me_V2()

//Grand father version 2 walk
grandFaterV2.walk()
//My parent version 2 walk
myParentV2.walk()
//Myself version 2 walk
meV2.walk()

//I create my son
let mySon = MySon()
//My son just like me so my son walk like me
//It print "Me version 2 walking at speed 30"
mySon.walk()

/**********
 We use inheritence to achieve same result
 in later version with less effort. I believe
 no one would ever do more work to achieve
 same result right?
 **********/

print("*******************************************************************************************************************\n\n\n")



/******************************************************************************************
 Protocol
 
 You are not my kind
 ******************************************************************************************/

/*****
 Protocol is a way to lower
 dependancy between objects
 *****/

/*****
 Dependancy
 *****/
class Data{
    var data : Int = 10
    var name : String = ""
    
    
    init() {
        
    }
}

class A:Data{
    
    var dataB : B
    
    //we get name and data from B and print it
    func printData(){
        print("Data B's name is \(self.dataB.name), data is \(self.dataB.data)")
    }
    
    
    init(inDataB : B) {
        
        self.dataB = inDataB
        
        //we call parent class's init()
        super.init()
        
        self.name = "A"
        self.data = 100
    }
}

class B:Data{
    
    //we override init from Data
    override init() {
        //we call parent class's init()
        super.init()
        
        self.name = "B"
        self.data = 200
    }
}

/**********
 Let's test it
 **********/
let objectB = B()
let objectA = A(inDataB: objectB)

//we use object A to print object B's name and data
objectA.printData()

print("*******************************************************************************************************************\n\n\n")


/**********
 We say A is depend on B in order to print B's name and data,
 therefore, dependancy between A and B is very high A can not
 live without B. Without B, A is not able to print data even you
 create C and give it to A, it still not work
 **********/
class C:Data{
    
    //we override init from Data
    override init() {
        //we call parent class's init()
        super.init()
        
        self.name = "c"
        self.data = 150
    }
}

//let objA = A(inDataB: C) //uncomment this to see compile error

print("*******************************************************************************************************************\n\n\n")



/**********
 Let's see the problem of dependancy
 
 Say a human can issue a command to any kind of object
 this human contact with to perform jump. To achieve this we can simply
 create an parent class(Animal) with jump method and other childrens inherit
 from it.
 **********/
class Animal{
    
    func jump(){
        //do nothing
    }
}

class Cat:Animal{
    
    override func jump(){
        print("Cat jump")
    }
}

class Dog:Animal{
    
    override func jump(){
        print("Dog jump")
    }
}

class Human{
    
    func commandJump(obj : Animal){
        obj.jump()
    }
}

/**********
 Let's test it
 **********/

let cat = Cat()
let dog = Dog()
let human = Human()

human.commandJump(obj: cat)
human.commandJump(obj: dog)

print("*******************************************************************************************************************\n\n\n")

/**********
 Now what if we change scenario say human
 can issue command meow to object which can perform
 meow? We know cat can meow but dog do not.
 
 To achieve it we just need to create meow method in parent class(Animal2)
 and then override it in children class but only limited
 to cat class
 **********/
class Animal2{
    
    func jump(){
        //do nothing
    }
    
    func meow(){
        //do nothing
    }
}

class Cat2:Animal2{
    
    override func jump(){
        print("Cat jump")
    }
    
    override func meow() {
        print("Cat meow")
    }
}

class Dog2:Animal2{
    
    override func jump(){
        print("Dog jump")
    }
    
    //we do not override eat method
    //since we do not do anything
}

class Human2{
    
    func commandJump(obj : Animal2){
        obj.jump()
    }
    
    func commandMeow(obj : Animal2){
        obj.meow()
    }
}

/**********
 Let's test it
 **********/
let cat2 = Cat2()
let dog2 = Dog2()
let human2 = Human2()

human2.commandMeow(obj: cat2)
human2.commandMeow(obj: dog2)

/**********
 It work as expected
 Only cat can meow but not dog
 **********/

print("*******************************************************************************************************************\n\n\n")

/**********
 We know cat and dog are animal
 so they both inherite from Animal parent
 class. But what if there is an object which
 is not animal? Let's say robot and robot can
 jump.
 
 So we create a parent class call Machine with
 method name jump and let robot inherite from it.
 You will relize that human is not able to issue
 command to robot but only cat and dog because command
 jump can only accept object that inherite from Animal class.
 Ooooops.
 
 The reason for this problem is because human's command jump is
 depend on Animal class and class that inherite from Animal.
 
 We need a solution for this problem
 **********/

/**********
 Protocol is a good solution for this kind of problem.
 Protocol is a thin layer between objects. Objects only
 communicate through protocol instead object it self.
 
 ObjectA ------> Protocol -------> ObjectB
 ObjectA <------ Protocol <------- ObjectB
 
                    vs
 
        ObjectA -------> OobjectB
        ObjectA <------- OobjectB
 
 Protocol can represent as a paper have method written
 on it but have no implementation. As long as, object
 that adapt and conform to protocol have to implment it
 
 Say we have a ProtocolA which have number of methods been written
 on it.
 
 An objectA adapt and conform to ProtocolA. As well as, implement
 methods that are written on ProtocolA.
 
 Now we have an objectB which have a reference to ProtocoalA which
 adapted by objectA. ObjectB can call method in ProtocolA to tell objectA
 to perform a method indirectly.
 
 Now objectA and objectB are not depend on each other instead they depend on
 protocol
 
 Protocol can only be adapted but can not be instantiated as object instance.
 **********/

//we define a protocol name JumpAble
protocol JumpAble{
    
    //jump method in protocol
    //do not implement it
    //only class who adapt and conform
    //to JumpAble have to implement it
    func jump()
}

/*******
 Animal
 *******/
class Animal3{
    
}

class Cat3:Animal3, JumpAble{
    
   //we implement jump in cat
   func jump() {
        print("Cat jump")
    }
}

class Dog3:Animal3, JumpAble{
    
    //we implement jump in dog
    func jump() {
        print("Dog jump")
    }
}

/*******
 Robot
 *******/
class Machine{
    
}

class Robot:Machine, JumpAble{
    
    //we implement jump in robot
    func jump() {
        print("Robot jump")
    }
}

//human
class Human3{
    
    func commandJump(obj : JumpAble){
        obj.jump()
    }
}

/**********
 Let's test it
 **********/
let cat3 = Cat3()
let dog3 = Dog3()
let robot = Robot()
let human3 = Human3()

human3.commandJump(obj: cat3)
human3.commandJump(obj: dog3)
human3.commandJump(obj: robot)

let animal3 = Animal3()

//Animal3 class do not conform to JumpAble protocol
//human3.commandJump(obj: animal3) //uncomment this to see error


/**********
 As you can see above code Cat3, Dog3 and Robot adapt and conform to protocol name JumpAble and
 implement method jump in that protocol. When human issue command jump the arguement type is type of
 JumpAble protocol. Thus human do not have to know anything about object that get passed into comandJump
 method, as long as object conform to JumpAble protocol. If there is object do not conform to JumpAble
 protocol then compiler will show error.
 
 After all, protocol allow objects to lower dependancy to each other while open object's communication.
 protocol can be plug into an object to allow the object to have certain ability and unplug when the object
 no long need it
 **********/

print("*******************************************************************************************************************\n\n\n")
