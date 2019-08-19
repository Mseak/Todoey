//
//  ViewController.swift
//  Todoey
//
//  Created by Mseak GR on 8/19/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    let itemArray = ["Find Mike", "Buy eggos", "Destroy Demogorgon"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Mark - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK -Table View Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let selectedTrail = trails[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        print(itemArray[indexPath.row])
        
    
    }
    
    
    
}

