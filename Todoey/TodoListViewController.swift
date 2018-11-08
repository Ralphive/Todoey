//
//  ViewController.swift
//  Todoey
//
//  Created by Ralph on 07/11/2018.
//  Copyright © 2018 Ralph. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController  {
    var itemArray = ["TodoOne", "Todo two", "To do three"]
    
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
    }

    //MARK: Tableview DS methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("User selected row\(indexPath.row) item \(itemArray[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
    }
    
    //MARK: Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            if (!textField.text!.isEmpty){
                    self.itemArray.append(textField.text!)
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

