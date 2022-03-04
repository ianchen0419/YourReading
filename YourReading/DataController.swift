//
//  DataController.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/26.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "YourReading")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to loaded: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
