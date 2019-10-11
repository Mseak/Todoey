//
//  ViewController.swift
//  Todoey
//
//  Created by Mseak GR on 8/19/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController{
    
    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
     
        didSet{
            
            loadItems()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
        
        
    }

    //MARK: - tableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
            if indexPath.row == 0{
                
                cell.backgroundColor = UIColor(hexString: item.cellColorHexValue)
            }else{
                
                let color = UIColor(hexString: item.cellColorHexValue)?.darken(byPercentage: CGFloat(indexPath.row)/CGFloat(todoItems!.count))
                cell.backgroundColor = color
                    cell.textLabel?.textColor = ContrastColorOf(color!, returnFlat: true)
            }
            
           // if let color = FlatWatermelon().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(todoItems!.count)){
                
              //  cell.backgroundColor = color
              //  cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            //}
            
            
        }else{
            cell.textLabel?.text = "No items added"
        }
        
         return cell
    }
    //MARK: -Table View Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //MARK: - Realm forma de hacer el codigo de checar la palomita del item con realm
        
        if let item = todoItems?[indexPath.row]{
            do {
                    try realm.write {
                        item.done = !item.done
                        
                }
            
            }catch{
                    print("Error saving the done state of the item \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Items Section
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
          //MARK: - Realm Codigo para cuando se presiona el boton de Add Item
            
            if let currentCategory = self.selectedCategory{
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date.init()
                        newItem.cellColorHexValue = self.selectedCategory!.cellColorHexValue
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error While Saving the new Item: \(error)")
                }
            }
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert ,animated: true, completion: nil)
         
    }
     //MARK: - Load Items con Realm
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        //todoItems = realm.objects(Item.self)
        
        tableView.reloadData()
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
           
        if let itemDeletion = self.todoItems?[indexPath.row]{
          
            do{
                try realm.write {
                    self.realm.delete(itemDeletion)
                }
                
            }catch{
                
                print("Error while deleting object \(error)")
            }
            
       }
    
    
    
    }
}
    
// MARK: - Search bar methods

extension  TodoListViewController :  UISearchBarDelegate {
    
   

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        todoItems = todoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }

    }
    
   
    
    
}
