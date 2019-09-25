//
//  ViewController.swift
//  Todoey
//
//  Created by Mseak GR on 8/19/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    
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
    //NO NECESITAMOS ESTA DIRECCION DE USER DEFAULTS
    //let defaults = UserDefaults.standard
    //ESTA INSTRUCCION CREA UNA VARIABLE PARA CONTENER UNA RUTA DE ARCHIVOS DENTRO DE LAS CARPETAS DE ARCHIVOS COMPARTIDOS
    //DE iOS
    
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!! OBSOLETO --->> SOLO NECESITABAMOS IMPRIMIR EL PATH DONDE CAERA LA INFORMACION
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    //EL SIGUIENTE CODIGO VA A REEMPLAZAR NUESTRA FORMA DE GUARDAR INFORMACION DENTRO DE LA PLIST. AHORA, VAMOS A UTILIZAR
    //CORE DATA, ENTONCES NECESITAMOS CREAR UNA VARIABLE CONTEXT Y UNA VARIABLE DE TIPO CORE DATA QUE SERA NUESTRO SUSTITUO DE
    //ITEM. EL CODIGO DE NUESTRA CLASE ITEM FUE BORRADO Y ESTA OBSOLETO. ------>
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath!)
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        //ESTA ES LA FORMA EN LA QUE SE DECLARA LA NUEVA LISTA DE DEFAULTS CON OBJETOS DE TIPO ITEM ********<< TAMBIEN OBSOLETO >>********
       /* if let item = defaults.array(forKey: "TodoListArray") as? [Item]{
            
            itemArray = item
         }
        */
       /*<<<<<<<<<<<<<<<<<< HA QUEDADO OBSOLETO AL USAR PERSISTENCIA DE DATOS CON NSCODER >>>>>>>>>>>>>>>>>>>>>>>>>>
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogrogon"
        itemArray.append(newItem3)
        */
        
       loadItems()
        
    }

    //MARK: - tableView Methods
    
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
    //MARK: -Table View Delegates
    /*Este metodo crea un manejador para hacer una accion cuando un item de la lista del table view sea seleccionado, en este caso
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
        
        //*************************************** El CODIGO ABAJO ES EXPERIMENTAL Y MUESTRA EL ORDEN Y LA SINTAXIS PARA
        //                                        PARA BORRAR ITEMS DE LA BASE DE DATOS Y DE LA TABLE VIEW *************************************
        
        //context.delete(itemArray[indexPath.row]) ----->>> primero removemos el item de la base de datos
        //itemArray.remove(at: [indexPath.row]) -------->>> despues removemos el item del arreglo de objetos
        
        
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
        saveItems()
        /* <<<<<<<<<<<<< RETIRAMOS ESTA LINEA PORQUE LA NUEVA FUNCION YA TIENE UN RELOAD ESCRITO >>>>>>>>>>>>>>>>>>
        tableView.reloadData()
        */
        print(itemArray[indexPath.row])
    }
    
    
    //MARK: - Add New Items Section
    
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
          //MARK: - Codigo para cuando se presiona el boton de Add Item
            
            
            
            /*
            Suplantamos el codigo creado para un arreglo de Strings y en su lugar se utilizara logica
            para un arreglo de objetos
             >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESTA DECLARACION DEL OBJETO newItem A QUEDADO OBSOLETA. YA NO ETAMOS USANDO
                                               PLIST LOCAL, AHORA ESTAMOS USANDO CORE DATA. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            let newItem = Item()
            */
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            
            // COMO LA FORMA DE SALVAR LOS NUEVOS ITEMS HA CAMBIADO A CORE DATA Y DENTRO DE ESE DATA MODEL TENEMOS QUE EL ATRIBUTO
            // DE "DONE" ES OBLIGATORIO, ENTONCES DEBEMOS SETEARLO AQUI EN FALSO SIEMPRE, YA QUE NINGUNA TAREA DEBE EMPEZAR HECHA.
            
            newItem.done = false
            
            
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
            
            /*************************<<<<<< ESTA LINEA TAMBIEN HA QUEDADO OBSOLETA >>>>>*****************************
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //Recuerda que aun se tiene que llamar la variable defaults. hay que ir a
                                                                        //AppDelegate y a la hora de cargar la app imprimir la ruta de guardado.
            */
            
            /****** <<<<<<<<< TODA ESTA SECCION SE MIGRARA A UNA NUEVA FUNCION DONDE SE SALVARAN TODOS LOS ATRIBUTOS EN LA PLIST >>>>>>  *******
            // SE CREA UNA NUEVA VARIABLE LLAMADA ENCODER QUE NOS SERVERIA PARA EL NSCODER
            
            let encoder = PropertyListEncoder()
            //LO SIGUIENTE (EL DO CATCH) LO TENEMOS QUE AGREGAR PORQUE XCODE NOS INDICA QUE PUEDEN SALIR ERRORES, POR LO TANTO PONEMOS LA INTRUCCION PARA INTENTE HACER EL COMANDO DE LO CONTRATIO ARROJAR EL ERROR.
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
                
            }catch {
                print("Error encoding item array \(error)")
                
            }***********************************************************************************************************************************
            */
            
            /*
            La siguiente linea de codigo hace que la informacion de la tableView se refresque en la Interfaz de usuario. ya que a la hora de añadir
            el nuevo elemento a la lista, esta se guarada a nivel memoria, sin embargo, la tabla permanece estatica hasta no indicarle que tiene
            nuevo elemento que debe de mostrar.
             
             self.tableView.reloadData()
            */
            self.saveItems()
            
            
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
    
    // Esta funcion salvara los items en la lista persistente de los documentos de la app en iOS
    func saveItems(){
        
        // SE CREA UNA NUEVA VARIABLE LLAMADA ENCODER QUE NOS SERVERIA PARA EL NSCODER
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!! YA NO NECESITAMOS ESTE ENCODER AHORA QUE ESTAMOS USANDO COREDATA !!!!!!!!!!!!!!!!!!!!!
        //let encoder = PropertyListEncoder()
        //LO SIGUIENTE (EL DO CATCH) LO TENEMOS QUE AGREGAR PORQUE XCODE NOS INDICA QUE PUEDEN SALIR ERRORES, POR LO TANTO PONEMOS LA INTRUCCION PARA INTENTE HACER EL COMANDO DE LO CONTRATIO ARROJAR EL ERROR.
        do{
            //let data = try encoder.encode(itemArray)  -->>> OBSOLETO CON CORE DATA
            //try data.write(to: dataFilePath!)   ----->>> OBSOLETO CON CORE DATA
            
            //INVOCAMOS EL METODO QUE NOS PROVEE XCODE PARA SALVAR A LA BASE DE DATOS
            try context.save()
            
        }catch {
            //print("Error encoding item array \(error)")
            // ATRAPAMOS EL ERROR QUE GENERE EL METODO COTEXT.SAVE
            print("Error saving context \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    
    //Esta funcion tratara de cargar los datos presistentes de la lista creada en los documentos de la app en iOS
    
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   ESTA FUNCION QUEDO OBSOLETA CUANDO CAMBIAMOS DE ENCODER A DATA MODEL !!!!!!!!!!!!!!!!!!!!!!!!!!!
    /*
    func loadItems(){
        
        /*
        creamos una variable llamada data que sera de tipo Data y que manda a lamar los contenidos de la plist indicada o de una URL externa
        En este caso la plist indicada sera la variable que creamos arriba llamada dataFilePath.
        como crear una variable tipo data nos puede traer un error, utilizamos el ya conocido arreglo de Try - Do - Catch
        */
        if let data = try? Data(contentsOf: dataFilePath!){
            
            //si se puede crear la variable data, creamos una variable decodificadora llamada decoder de tipo PropoertyListDecoder
            //y despues le herdamos a itemArray los atributos de decoder para asi cargar los datos que fueron guardados en la plist.
            
            let decoder = PropertyListDecoder()
             do {
                
                //<<<<<<<<<<<<<<<<<<<< PARA QUE ESTA INSTRUCCION FUNCIONE, SE TIENE QUE ESPECIFICAR EL PROTOCOLO "CODABLE" EN EL OBJETO ITEM
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding itemArray \(error)")
            }
        }
        
        
        
    }
     */
    
    // >>>>>>>>>>>>>>>>>>>>> CREAMOS DE NUEVO LA FUNCION DE CARGA DE DATOS PERO AHORA CON METODOLOGIA CORE DATA Y NO CON ENCODING <<<<<<<<<
    //  SEGUNDA MODIFICACION : Como podemos observar la funcion de load puede servirnos tanto como para hacer busquedas totales como tambien
    //  para hacer las busquedas de la searchbar por lo tanto añadimos un parametro externo 'With' y uno interno 'request' y ademas
    //  añadimos un valor default para la invocacion que tenemos en el metodo didFinishedLoading
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()){
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray = try context.fetch(request)
            
        }catch{
            
            print("Error fetching data from context issue : \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
}

// !!!!!!!!!!!!!!!!!!! ESTAMOS UTILIZANDO LA PALABRA RESERVADA EXTENSION PARA ASI DECLARAR QUE NECESITAMOS LAS FUNCIONALIDADES DE
//                     DE LA BARRA DE BUSQUEDA SIN TENER QUE DECLARARLO EN LA FUNCION PRINCIPAL. ESTO AYUDA A TENER EL CODIGO MEJOR
//                     SECCIONADO PARA IDENTIFICAR QUE SECCIONES LLEVAN A CABO FUNCIONES QUE SE REQUIERAN INSPECCIONAR.
//                     ESTO APLICA PARA CUALQUIER DELEGATE DE OTROS TIPOS COMO PICKER VIEWS ETC. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// MARK: - Search bar methods

extension  TodoListViewController :  UISearchBarDelegate {
    
    //!!!!!!!!!!!!!!!! TODO ESTE BLOQUE DE CODIGO ES COMO ORIGINALMENTE SE PLANEO PERO HACIENDO REFACTOR PUEDE QUEDAR MAS COMPACTO
    //                 DESPUES DEL CODIGO COMENTADO SIGUE EL REFACTOR
    /*
    // Esta funcion es la que necesitamos para insertar logica cuando el usuario toque la barra de busqueda
   
        
        // Definimos una variable interna de busqueda con la sintaxis de core Data NSfetchRequest<Tipo de item que se va a recueerar>  = Variable.FetchRequest()
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        print(searchBar.text!)
        
        //Con la siguiente sentencia vamos a crear un 'Predicate', esto es equivalente un query dentro de nuestro core data model.
        // la sintaxis es let predicate = NSPredicate.init(format: "AQUI VA EL QUERY", Args (Argumentos o parametros de busqueda))
        
        let predicate = NSPredicate.init(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        // Ahora que tenemos armado el predicate, podemos asignarle a la variable request su predicate
        request.predicate = predicate
        
        // podemos añadirle a la busqueda funcionalidad de ordenamiento de datos, creando una variable de tipo NSsortDescriptor
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        //Ahora que tenemos armado nuestro query completo es hora de invocarlo, y para esto podemos pedir prestado el codigo de la funcion anterior
        //load items porque en esa funcion tenemos ya codigo que sirve para hacer el fetch request.
        
        do{
            itemArray = try context.fetch(request)
            
        }catch{
            
            print("Error fetching data from context issue : \(error)")
        }
        
        // reload tableView
        tableView.reloadData()
        */

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
            let request : NSFetchRequest<Item> = Item.fetchRequest()
        
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            loadItems(with: request)
        
            //tableView.reloadData()
    }
    //Esta Funcion Sirve para regresar la vista de la tabla completa sin filtro
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //Utilizamos un if simple para determinar si es necesario limpiar la busqueda
        //En este caso si observamos que la cadena de caracteres tiene una extension de cero
        //letras, podemos asumir que la busqueda se borro y es necesario revertir el filtro.
        if searchBar.text?.count == 0{
            
            loadItems()
            
            //Despues de limpiar la busqueda, utilizamos la funcion de abajo para despojar
            //a la barra de busqueda del focus del procesamiento, esto para despedir al teclado
            //y quitar el cursor de la barra de busqueda
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }

    }
}
