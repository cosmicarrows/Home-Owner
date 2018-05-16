//
//  ItemStore.swift
//  Home Owner
//
//  Created by Laurence Wingo on 5/14/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import Foundation
import UIKit

class ItemStore {
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item.init(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        //Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
