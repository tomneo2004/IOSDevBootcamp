//
//  Category.swift
//  Todoey
//
//  Created by Nelson on 9/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}

/*
 Realm say use let is probably base on 2 reasons
 1. Code safty
 2. Realm rely on this property to keep relationship between model object
 
 Code safy:
 When you work with/without other people on project you are safe to use this property. When some day or at some point, you or other programmer try to assign an new value to it like this selectedCategory?.items = List<Item>() it will throw an error while compiling your code, then you or other people know not to change it's value.
 If you use var instead of let then compiler will not complain. When you or other people do selectedCategory?.items = List<Item>() it still fine, however, your category object lost all relationship to corresponding items.
 
 Relationship between model object:
 As above had mentioned. Realm only modify the element in list not to assign a new value to your items property.
 
 In conclusion. let is used to define a property that can only be modified once it is assigend a value, on the other hande, var is used to define a property that can be assigned a new value at any given time while it can be modified as well.
 */
