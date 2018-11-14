//
//  ViewController.swift
//  Todoey
//
//  Created by Ralph on 07/11/2018.
//  Copyright © 2018 Ralph. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework

class TodoListViewController: UITableViewController  {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory : TodoCategory? {
        didSet{
            loadData()
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //personal folder for this app
        
        print("Diretorio é o \(dataFilePath)")
        searchBar.delegate = self
        tableView.separatorStyle = .none

        
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
        if let color = UIColor(hexString: selectedCategory!.color!)?.darken(byPercentage: CGFloat(indexPath.row)/CGFloat(itemArray.count)){
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)

        }
            
        cell.accessoryType = item.checked ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("User selected row\(indexPath.row) item \(itemArray[indexPath.row].itemName)")
        
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        
        tableView.deselectRow(at: indexPath, animated: true)
        saveData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    //MARK: Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
            if (!textField.text!.isEmpty){
                self.itemArray.append(Item(context: self.context, itemName: textField.text!, parentCategory: self.selectedCategory!))
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
    
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let predicate = request.predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, categoryPredicate])
        }else{
             request.predicate = categoryPredicate
        }
        
       
        do{
            try itemArray = context.fetch(request)
            tableView.reloadData()
        }catch{
            print("Errror Fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    func queryData(){
        //Create Request
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //Set conditions
        request.predicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchBar.text!)
        //Set Sorting
        request.sortDescriptors = [NSSortDescriptor(key: "itemName", ascending: true)]
        //Load Data
        loadData(with: request)
    }
    
    //MARK: Todo List deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

//MARK: Search Bar Methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            queryData()
        }
    }
}

