//
//  categoryViewController.swift
//  Todoey
//
//  Created by Mseak GR on 9/24/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit
import CoreData


class categoryViewController: UITableViewController {
    
    var categories = [Category2]()
    let context2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

     
    }
//MARK: - Add New Items Section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield2 = UITextField()
        let alert2 = UIAlertController(title: "Add New Cathegory", message: " ", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "Add", style: .default) { (action2) in
            
            let newCategory = Category2(context: self.context2)
            
            newCategory.name = textfield2.text
            
            self.categories.append(newCategory)
             self.saveCategories()
        }
        
        
        alert2.addTextField { (alert2Textfield) in
            
            alert2Textfield.placeholder = "Create New Category"
            textfield2 = alert2Textfield
            
        }
        
        alert2.addAction(action2)
        present(alert2, animated: true, completion: nil)
        
       
        
    }
    
    //MARK: - TableView Data Source Method

    /*
    Funcion para cargar el numero de objetos en la tabla
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
     
    /*
    Esta Funcion Abajo es para obtener el texto de la tabla de category
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
     //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = categories[indexPath.row]
            
        }
    }
    
    
     //MARK: - Data Manipulation Methods
       /*
        Esta Funcion es para salvar los datos en la tabla una vez añadidos
       */
    func saveCategories(){
              
              do{
                  try context2.save()
              }catch{
                  print("Error While Saving Categories: \(error)")
              }
              self.tableView.reloadData()
              
    }
          
          /*
          Funcion para cargar la tabla
          */
    func loadCategories(with request : NSFetchRequest<Category2> = Category2.fetchRequest()){
              
              do {
                  categories = try context2.fetch(request)
              }catch{
                  print("Error fetching data from context issue : \(error)")
              }
              tableView.reloadData()
    }
          
    
   
    
   
    
    
    
}
