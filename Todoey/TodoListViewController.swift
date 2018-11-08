//
//  ViewController.swift
//  Todoey
//
//  Created by Ralph on 07/11/2018.
//  Copyright © 2018 Ralph. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController  {
    var itemArray = [Item]()
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemArray += [Item(itemName: "Find Mike"),Item(itemName: "Find Mike"), Item(itemName: "Kill Demogorgon")]
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }
    
    //MARK: Tableview DS methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.itemName
        cell.accessoryType = item.checked ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("User selected row\(indexPath.row) item \(itemArray[indexPath.row].itemName)")
        
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()

    }
    
    //MARK: Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            
            
            if (!textField.text!.isEmpty){
                self.itemArray.append(Item(itemName: textField.text!))
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
            }
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}

