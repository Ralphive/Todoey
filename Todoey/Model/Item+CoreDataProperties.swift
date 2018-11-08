//
//  Item+CoreDataProperties.swift
//  Todoey
//
//  Created by Ralph on 08/11/2018.
//  Copyright © 2018 Ralph. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var checked: Bool
    @NSManaged public var itemName: String?
    @NSManaged public var parentCategory: TodoCategory?
    
    convenience init(context: NSManagedObjectContext,itemName: String, parentCategory: TodoCategory) {
        self.init(context:context)
        self.itemName = itemName
        self.checked = false
        self.parentCategory = parentCategory
        
    }

}
