//
//  Item.swift
//  Todoey
//
//  Created by Ralph on 08/11/2018.
//  Copyright © 2018 Ralph. All rights reserved.
//

import Foundation

class Item {
    var itemName : String
    var checked : Bool
    
    init(itemName: String) {
        self.itemName = itemName
        self.checked = false
    }
    
    
}
