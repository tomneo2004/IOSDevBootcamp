//
//  Item.swift
//  Todoey
//
//  Created by Nelson on 9/7/19.
//  Copyright © 2019 Nelson. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date = Date()
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
