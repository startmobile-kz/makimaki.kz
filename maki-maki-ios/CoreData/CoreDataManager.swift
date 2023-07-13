//
//  CoreDataManager.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 09.07.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: State
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    // MARK: Lifecycle
    
    private init() {}
    
    func addSelectedProduct(product: RestaurantProduct) {
        let context = persistentContainer.viewContext
        let selectedProduct = SelectedProduct(context: context)
        selectedProduct.id = Int16(product.id)
        selectedProduct.count = Int16(product.count)
        selectedProduct.category = Int16(product.category)
        
        do {
            try context.save()
        } catch let error {
            print("Failed to add: \(error)")
        }
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
    
    func fetchSelectedProduct(withID id: Int) -> SelectedProduct? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SelectedProduct>(entityName: "SelectedProduct")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let products = try context.fetch(fetchRequest)
            return products.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        return nil
    }
    
    func updateSelectedProduct(product: RestaurantProduct) {
        let context = persistentContainer.viewContext
        let selectedProduct = fetchSelectedProduct(withID: product.id)
        selectedProduct?.count = Int16(product.count)
        do {
            try context.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
    func deleteSelectedProduct(product: RestaurantProduct) {
        let context = persistentContainer.viewContext
        
        guard let selectedProduct = fetchSelectedProduct(withID: product.id) else {
            print("Couldn't fetch product with this id.")
            return
        }
        context.delete(selectedProduct)
        
        do {
            try context.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
    
    func deleteData() {
        let context:NSManagedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SelectedProduct")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
            try context.save()
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }
}
