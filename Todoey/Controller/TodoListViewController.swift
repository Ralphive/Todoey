//
//  ViewController.swift
//  Todoey
//
//  Created by Ralph on 07/11/2018.
//  Copyright © 2018 Ralph. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController  {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //personal folder for this app
        
        print("Diretorio é o \(dataFilePath)")
        
        loadData()
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
        saveData()
    }
    
    //MARK: Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            if (!textField.text!.isEmpty){
                self.itemArray.append(Item(context: self.context, itemName: textField.text!))
                self.saveData()
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
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print ("Error Saving Core data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            try itemArray = context.fetch(request)
        }catch{
            print("Errror Fetching data from context \(error)")
        }
        
 
    }
    
}

