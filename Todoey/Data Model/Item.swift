//
//  Item.swift
//  Todoey
//
//  Created by Nicholas Gavin on 1/8/19.
//  Copyright © 2019 Nicholas Gavin. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
