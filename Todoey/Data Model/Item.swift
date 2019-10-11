//
//  Item.swift
//  Todoey
//
//  Created by Mseak GR on 10/2/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    @objc dynamic var cellColorHexValue : String = ""
    
    
    //MARK: - Referencia a la Entidad Padre Category
    //Esta sentencia permite a Swift saber que la entidad Items, depende de una relacion con la clase de Category de 1 a varios. Se utiliza la palabra reservada LinkingObjects(fromType:  , property:) para hacer la instancia.
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
