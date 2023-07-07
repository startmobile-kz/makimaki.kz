//
//  SaveSearch .swift
//  maki-maki-ios
//
//  Created by Ravil on 07.07.2023.
//

import Foundation
import CoreData
import UIKit

func saveRecentSearch(name: String) {
    
    var searchObject: [NSManagedObject] = []
    
    guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext =
        appDelegate.persistentContainer.viewContext
    
    let entity =
        NSEntityDescription.entity(forEntityName: "SearchHistory",
                               in: managedContext)!
    
    let searchHistory = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    searchHistory.setValue(name, forKeyPath: "name")
    
    do {
        try managedContext.save()
        searchObject.append(searchHistory)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}
