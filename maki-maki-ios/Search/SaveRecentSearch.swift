//
//  RecentSearchService.swift
//  maki-maki-ios
//
//  Created by Ravil on 07.07.2023.
//

import Foundation
import CoreData
import UIKit

class RecentSearchService {
    
    private let managedContext: NSManagedObjectContext
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    // Create
    func createRecentSearch(name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Recent", in: managedContext)!
        let searchHistory = NSManagedObject(entity: entity, insertInto: managedContext)
        searchHistory.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Read
    func fetchAllRecentSearches() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Recent")
        
        do {
            let searchObject = try managedContext.fetch(fetchRequest)
            return searchObject
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Update
    func updateRecentSearch(_ searchObject: NSManagedObject, withName name: String) {
        searchObject.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    // Delete
    func deleteRecentSearch(_ searchObject: NSManagedObject) {
        managedContext.delete(searchObject)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
