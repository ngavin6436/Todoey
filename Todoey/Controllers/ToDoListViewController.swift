//
//  ViewController.swift
//  Todoey
//
//  Created by Nicholas Gavin on 12/13/18.
//  Copyright © 2018 Nicholas Gavin. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var myArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
    }

    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = myArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myArray[indexPath.row].done = !myArray[indexPath.row].done
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addItemPressed(_ sender: Any) {
        
        var textEntered = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens when user clicks "add"
            
            let newItem = Item()
            newItem.title = textEntered.text!

            self.myArray.append(newItem)
            self.saveItems()
            self.tableView.reloadData()

        }
    
        alert.addTextField { (alertTextField: UITextField) in
            alertTextField.placeholder = "Create New Item"
            textEntered = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.myArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            myArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding array: \(error)")
            }
        }
    }
}

