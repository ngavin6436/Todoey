//
//  ViewController.swift
//  Todoey
//
//  Created by Nicholas Gavin on 12/13/18.
//  Copyright © 2018 Nicholas Gavin. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var myArray = ["The first Item", "Second one", "Another one"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            myArray = items
        }
    }

    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = myArray[indexPath.row]
        return cell
    }
    
    //Mark - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(myArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addItemPressed(_ sender: Any) {
        
        var textEntered = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens when user clicks "add"

            self.myArray.append(textEntered.text ?? "")
            self.defaults.set(self.myArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()

        }
    
        alert.addTextField { (alertTextField: UITextField) in
            alertTextField.placeholder = "Create New Item"
            textEntered = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

