//
//  CoreDataManager.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 09.07.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: State
    
    let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    // MARK: Lifecycle
    
    private init() {}

}
