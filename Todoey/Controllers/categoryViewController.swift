//
//  categoryViewController.swift
//  Todoey
//
//  Created by Mseak GR on 9/24/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit
import RealmSwift


class categoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

     
    }
//MARK: - Add New Items Section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield2 = UITextField()
        let alert2 = UIAlertController(title: "Add New Cathegory", message: " ", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "Add", style: .default) { (action2) in
            
            let newCategory = Category()
            newCategory.name = textfield2.text!
            
       
            self.save(category: newCategory)
        }
        
        
        alert2.addTextField { (alert2Textfield) in
            
            alert2Textfield.placeholder = "Create New Category"
            textfield2 = alert2Textfield
            
        }
        
        alert2.addAction(action2)
        present(alert2, animated: true, completion: nil)
        
       
        
    }
    
    //MARK: - TableView Data Source Method

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
     
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        //let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
        
    }
    
     //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    
    
     //MARK: - Data Manipulation Methods
      
    func save(category : Category){
              
              do{
                try realm.write {
                    realm.add(category)
                }
              }catch{
                  print("Error While Saving Categories: \(error)")
              }
              self.tableView.reloadData()
              
    }
          
         
    func loadCategories(){
        
            categories = realm.objects(Category.self)
        
            tableView.reloadData()
         
    
    }
          
    
   
    
   
    
    
    
}
