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
    Definimos a variable de tipo arreglo con el cual introduciremos elementos a la tableview [OBSOLETO] - Leccion 239
     
    *********************************************************************
    var itemArray = ["Find Mike", "Buy eggos", "Destroy Demogorgon"]
    *********************************************************************
    La nueva forma de declarar el arreglo es con objetos de la nueva clase Item que creamos en la leccion 239 de la siguiente forma
    */
    
    var itemArray = [Item]()
    
    /*
     La siguiente Variable esta creada para iniciar la clase acerca de informacion persistente. este metodo de retencion de
     informacion esta hecho para retener pequeños bancos de informacion en una app de consumo de recursos minimos como es el caso
     de la practica de todoey
    */
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        En esta parte vamos a obtener la informacion de la lista guardada en la llave que creamos con la variable defaults con la
        siguiente sentencia. OJO: Esto sirve debido a que nosotros tenemos en hardcode una lista y Xcode sabe que no encontrara
        valores nulos pero si no hubiera items en la lista el programa crashearia. por lo que primero debemos poner una variable de prueba
        y un if en caso de que no haya lista.
        */
        
       /*
                Este codigo Ha quedado obsoleto a partir de la leccion 229 en la que ya no estamos utilizando un arreglo de Strings sino un
                Arreglo de objetos de la clase Item que creamos.
         ***************************************************************************
         if let item = defaults.array(forKey: "TodoListArray") as? [String]{
            
            itemArray = item
        }
        ****************************************************************************
        */
        //ESTA ES LA FORMA EN LA QUE SE DECLARA LA NUEVA LISTA DE DEFAULTS CON OBJETOS DE TIPO ITEM
        if let item = defaults.array(forKey: "TodoListArray") as? [Item]{
            
            itemArray = item
        }
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem.title = "Destroy Demogrogon"
        itemArray.append(newItem3)
        
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
        //LO SIGUIENTE ES PARA ACORTAR EL CODIGO
        let item = itemArray[indexPath.row]
        
        //LA LINEA DE ABAJO QUEDARA REEMPLAZADA POR UNA MAS CORTA
        //cell.textLabel?.text = itemArray[indexPath.row].title
        cell.textLabel?.text = item.title
        
        /*****************TODAS ESTAS 5 LINEAS DE CODIGO PUEDEN SER SUSTITUIDAS POR EL TERNARY OPERATOR ==>
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        */
        //SINTAXIS DEL TERNARY OPRATOR ----> [ VALUE = CONDITION ? VALUEIFTRUE : VALUEIFFALSE ]
        
        cell.accessoryType = item.done ? .checkmark : .none
        
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
        
        // CON LA FORMA DE ARREGLO CON OBJETOS AHORA SOLO DEBEMOS INVOCAR SUS PROPIEDADES PARA CAMBIAR EL CHECKMARK
        //************************ESTE CODIGO SE BORRA PORQUE EXISTE UNA FORMA MAS COMPACTA DE DECLARARLO**********************
       /* if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }*/
        //EL SIGUIENTE CODIGO ES EQUIVALENTE A LA INSTRUCCION DE ARRIBA
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        /*************************EL CODIGO ABAJO QUEDA OBSOLETO CON EL CAMBIO A UN ARREGLO DE OBJETOS**************************
         El siguiente if es el que no permite revisar si el item de la lista tiene ya un checkmark al ser tocado y si lo tiene,
         Quitar el checkmark. si no lo tiene al momento de ser tocado le coloca el checkmark
        *//*
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }*/
        /*
        Con esta linea imprimimos en consola el contenido de la variable local indexPath para comprobar que se entra dentro de este metodo y todo
        esta bien
        */
        tableView.reloadData()
        
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
          //MARK - Codigo para cuando se presiona el boton de Add Item
            
            /*
            Suplantamos el codigo creado para un arreglo de Strings y en su lugar se utilizara logica
            para un arreglo de objetos
            */
            
            let newItem = Item()
            newItem.title = textField.text!
            
            //********************CODIGO HA QUEDADO OBSOLOTO - LA FORMA DE AÑADIR ITEMS CAMBIO DE STRINGS A OBJETOS******************************
            
            /*En esta seccion vamos a crear el codigo para insertar los nuevos items que haya creado el usuario
            Para lo siguiente debemos tener una variable global tipo array mutable (var, no let) y la invocamos con su metodo .append que es el
            que nos permite añadir elementos al arreglo y a este le añadimos la variable textfield con su atributo .text de la siguiente manera
            De igual forma hay que usar el atributo de self. para darle a conocer a Xcode que hablamos de la variable itemArray que declaramos
            arriba ya que nos encontramos en un closure.
 
            self.itemArray.append(textField.text!)*/
            //La nueva linea para append sera a siguiente
            
            self.itemArray.append(newItem)
            /*
            Esta instruccion colocada a continuacion es lo que nos va a permitir guardar datos aun estando fuera de la aplicacion. con el uso
            de la variable de tipo default que creamos antes lo que haremos sera guardar todo el itemArray[] dentro de ella. no olvidemos
            utilizae el self. ya que estamos dentro de un closure.
            */
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //Recuerda que aun se tiene que llamar la variable defaults. hay que ir a
                                                                        //AppDelegate y a la hora de cargar la app imprimir la ruta de guardado.
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
