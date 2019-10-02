//
//  AppDelegate.swift
//  Todoey
//
//  Created by Mseak GR on 8/19/19.
//  Copyright © 2019 Mseak GR. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // MARK: - Creamos una nueva instancia de REALM
        //crearla puede generar error por lo que se inicializa utilizando un DO TRY CATCH block
        
        do{
            _ = try Realm()
        }catch{
            
            print("Error Initializing realm parameter \(error)")
        }
        
        
        /*
        Esta linea de codigo hara que se imprima del directorio de documentos del usuario en turno la ultima direccion de momoria que utilizo
        El programa en forma de String
        */
       // print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        return true
    }

    


}

