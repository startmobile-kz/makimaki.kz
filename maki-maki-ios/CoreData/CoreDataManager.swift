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
    
    func addSelectedProduct(product: RestaurantProduct) -> SelectedProduct? {
        let context = persistentContainer.viewContext
        
        let selectedProduct = SelectedProduct(context: context)
        selectedProduct.id = Int16(product.id)
        selectedProduct.count = Int16(product.count)
        
        do {
            try context.save()
            return selectedProduct
        } catch let error {
            print("Failed to add: \(error)")
        }
        return nil
    }
    
    func fetchSelectedProducts() -> [SelectedProduct] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SelectedProduct>(entityName: "SelectedProduct")
        
        do {
            let selectedProducts = try context.fetch(fetchRequest)
            return selectedProducts
        } catch let error {
            print("Failed to fetch selected products: \(error)")
        }
        return []
    }

}
