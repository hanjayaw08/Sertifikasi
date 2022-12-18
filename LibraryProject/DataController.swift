//
//  DataController.swift
//  LibraryProject
//
//  Created by Hanjaya Putra Wijangga on 18/12/22.
//
import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Library")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load : \(error.localizedDescription)")
            }
        }
    }
}
