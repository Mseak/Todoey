//
//  Category.swift
//  Todoey
//
//  Created by Mseak GR on 10/2/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import Foundation
import RealmSwift

//La forma de de hacer una base de entidad relacion con REALM es creando clases de las entidades en este caso es una clase para las categorias de tipo Object que es el tipo que destina REALM para crear sus entidades
class Category : Object {
    
    //MARK: - declaracion de atributos REALM
    //la sigueinte es la forma de crear un atributo de esta entidad. se tienen que usar los pre fijos ' @objc dynamic ' Esto es lo que le permite a Swift cmbiar esta variable de forma dinamica en tiempo de ejecucion
    @objc dynamic var name : String = " "
    @objc dynamic var cellColorHexValue: String = ""
    
    // MARK: - Definicion de la relacion con su entidad hija
    //la siguiente sentencia declara como se debe referenciar a la clase o entidad padre del modelo de datos. en este caso para referenciar a la entidad Items, y se declara de forma que se hace un arreglo del tipo List (palaba reservada del framework RealSwift) y que contendra objetos de tipo Item (objeto de nuestra entidad Hija)
    
    let items = List<Item>()
}
