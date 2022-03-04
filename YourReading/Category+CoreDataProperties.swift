//
//  Category+CoreDataProperties.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/26.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var book: NSSet?

    public var wrappedName: String {
        name ?? "Unknown category"
    }
    
    public var bookList: [Book] {
        let set = book as? Set<Book> ?? []
        
        return set.sorted {
            $0.titleText < $1.titleText
        }
        
    }

}

// MARK: Generated accessors for book
extension Category {

    @objc(addBookObject:)
    @NSManaged public func addToBook(_ value: Book)

    @objc(removeBookObject:)
    @NSManaged public func removeFromBook(_ value: Book)

    @objc(addBook:)
    @NSManaged public func addToBook(_ values: NSSet)

    @objc(removeBook:)
    @NSManaged public func removeFromBook(_ values: NSSet)

}

extension Category : Identifiable {

}
