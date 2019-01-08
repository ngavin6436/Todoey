//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nicholas Gavin on 1/8/19.
//  Copyright © 2019 Nicholas Gavin. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var myArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = myArray[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {        
        do{
            myArray = try context.fetch(request)
        } catch {
            print("Error fetching items \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textEntered = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what happens when user clicks "add"
            
            let newItem = Category(context: self.context)
            newItem.name = textEntered.text!
            
            self.myArray.append(newItem)
            self.saveItems()
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField: UITextField) in
            alertTextField.placeholder = "Create New Category"
            textEntered = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = myArray[indexPath.row]
        }
    }
}

