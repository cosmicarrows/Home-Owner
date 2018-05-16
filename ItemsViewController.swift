//
//  ItemsViewController.swift
//  Home Owner
//
//  Created by Laurence Wingo on 5/14/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import Foundation
import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$ \(item.valueInDollars)"
        cell.backgroundColor = UIColor.purple
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets.init(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        //make a new index path for the 0th section, last row
        //let lastRow = tableView.numberOfRows(inSection: 0)
        //let indexPath = NSIndexPath.init(row: lastRow, section: 0)
        //insert this new row into the table
        //tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        
        //create a new item and add it to the store
        let newItem = itemStore.createItem()
        //figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = NSIndexPath.init(row: index, section: 0)
            //Insert this new row into the table
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        //if you are currently in editing mode...
        if isEditing {
            //change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            //turn off editing mode
            setEditing(false, animated: true)
        } else {
            //change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            //enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //if the tableVIew is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            //remove the item from the store
            itemStore.removeItem(item: item)
            //Also remove that row from the tableView with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //update the model
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
}
