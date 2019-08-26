//
//  Item.swift
//  Todoey
//
//  Created by Mseak GR on 8/22/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//
import Foundation
/*
Creamos la clase que servira para darle atributos a cada item de nuestra lista, en este caso los atributos son el titulo y un valor booleano que
Dictara si la tarea ha sido completada o no.
*/

class Item : Codable{
    
    /*
    Estas son las variables atributo que necesitamos
    */
    var title : String = ""
    var done : Bool = false

    
}


