//
//  ViewController.swift
//  Todoey
//
//  Created by Mseak GR on 8/19/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    /*
    Definimos a variable de tipo arreglo con el cual introduciremos elementos a la tableview
    */
    var itemArray = ["Find Mike", "Buy eggos", "Destroy Demogorgon"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Mark - Table View Methods
    
    /*
     Este metodo contiene el codigo necesario para recuperar el contenido de la tableView y obtener el siguiente numero de la lista de Items
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    /*
    Con este metodo obtenemos el texto del item deseado de la lista de objetos en el TableView
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    /*MARK -Table View Delegates
    /Este metodo crea un manejador para hacer una accion cuando un item de la lista del table view sea seleccionado, en este caso
    /se colocara una marca de check cada vez que el item sea tocado
    /
    /se declara el metodo a continuacion con el parametro de didSelectRow
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         Esta linea quita la seleccion del item tocado de manera animada para que la interfaz tenga mas estetica
        */
        tableView.deselectRow(at: indexPath, animated: true)
        /*
         El siguiente if es el que no permite revisar si el item de la lista tiene ya un checkmark al ser tocado y si lo tiene,
         Quitar el checkmark. si no lo tiene al momento de ser tocado le coloca el checkmark
        */
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        /*
        Con esta linea imprimimos en consola el contenido de la variable local indexPath para comprobar que se entra dentro de este metodo y todo
        esta bien
        */
        print(itemArray[indexPath.row])
    }
    
    
    //MARK - Add New Items Section
    //Esta funcion hace el mapeo del signo de mas en la interfaz de la app
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        /*
        Esta instruccion crea un campo de escritura en blanco que puede ser utilizado dentro de todo el IBAction del boton de addNew Item
        Esto es necesario porque dentro del closure de addTextfield no se puede sacar la variable alertTextField por lo que hacemos que esta nueva
        variable sea visible dentro y fuera de cualquier metodo en esta IBAction.
        */
        var textField = UITextField()
        
        //Esta instruccion crea una variable de tipo UIAlertController con titulo mensaje y estilo
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //Esta instruccion me crea una accion que el programa hara cuando mi boton de + se presione y que añadira un nuevo item a mi col
        //de todoey
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            /*MARK - Codigo para cuando se presiona el boton de Add Item
            En esta seccion vamos a crear el codigo para insertar los nuevos items que haya creado el usuario
            Para lo siguiente debemos tener una variable global tipo array mutable (var, no let) y la invocamos con su metodo .append que es el
            que nos permite añadir elementos al arreglo y a este le añadimos la variable textfield con su atributo .text de la siguiente manera
            De igual forma hay que usar el atributo de self. para darle a conocer a Xcode que hablamos de la variable itemArray que declaramos
            arriba ya que nos encontramos en un closure.
            */
            self.itemArray.append(textField.text!)
            /*
            La siguiente linea de codigo hace que la informacion de la tableView se refresque en la Interfaz de usuario. ya que a la hora de añadir
            el nuevo elemento a la lista, esta se guarada a nivel memoria, sin embargo, la tabla permanece estatica hasta no indicarle que tiene
            nuevo elemento que debe de mostrar.
            */
            self.tableView.reloadData()
            
            
        }
        
        //Creamos el espacio para texto dentro de la alerta con la funcion alert.addTexfield(){}
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        //creamos el lamado a la accion
        alert.addAction(action)
        //crea la animacion del mensaje en donde el usuario escribira el titulo del nuevo item de la lista de TO DO
        present(alert ,animated: true, completion: nil)
        
        
    }
    
    
}

