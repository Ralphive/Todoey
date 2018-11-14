//
//  TodoCategory+CoreDataProperties.swift
//  Todoey
//
//  Created by Ralph on 08/11/2018.
//  Copyright © 2018 Ralph. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoCategory> {
        return NSFetchRequest<TodoCategory>(entityName: "TodoCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension TodoCategory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
