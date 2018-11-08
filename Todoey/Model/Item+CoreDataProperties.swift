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

    @NSManaged public var itemName: String?
    @NSManaged public var checked: Bool
    
    
    convenience init(context: NSManagedObjectContext,itemName: String) {
        self.init(context:context)
        self.itemName = itemName
        self.checked = false
        
    }

}
