//
//  Book+CoreDataProperties.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/26.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    public var isReadEnd: Bool? {
        get {
            willAccessValue(forKey: "isReadEnd")
            defer { didAccessValue(forKey: "isReadEnd") }
            
            return primitiveValue(forKey: "isReadEnd") as? Bool
        }
        
        set {
            willChangeValue(forKey: "isReadEnd")
            defer { didAccessValue(forKey: "isReadEnd") }
            
            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "counter")
                return
            }
            
            setPrimitiveValue(value, forKey: "counter")
        }
    }
    
    @NSManaged public var isbn_13: String?
    @NSManaged public var title: String?
    @NSManaged public var publishedDate: Date?
    @NSManaged public var startRead: Date?
    @NSManaged public var endRead: Date?
    @NSManaged public var detail: String?
    @NSManaged public var thumbnail: URL?
    @NSManaged public var author: NSMutableSet?
    @NSManaged public var category: NSMutableSet?
    
    public var readStatusText: String {
        if isReadEnd == true {
            return "已閱讀"
        } else if isReadEnd == false {
            return "正在閱讀"
        } else {
            return "尚未閱讀"
        }
    }
    
    public var isbn_13Text: String {
        isbn_13 ?? "Unknown ISBN"
    }
    
    public var titleText: String {
        title ?? "Unknown Title"
    }
    
    public var publishedDateText: String {
        if let date = publishedDate {
            return date.toString()
        } else {
            return "-"
        }
    }
    
    public var startReadText: String {
        if let date = startRead {
            return date.toString()
        } else {
            return "-"
        }
    }
    
    public var endReadText: String {
        if let date = endRead {
            return date.toString()
        } else {
            return "-"
        }
    }
    
    public var detailText: String {
        detail ?? "Unknown Detail"
    }
    
    public var wrappedThumbnail: URL {
        thumbnail ?? URL(string: "https://fakeimg.pl/256x374/?text=Book")!
    }
    
    public var authorText: String {
        let set = author as? Set<Author> ?? []
        let array = [Author](set)
        let mappedArray = array.map{ $0.wrappedName }
        if mappedArray.count > 0 {
            return mappedArray.joined(separator: "、")
        } else {
            return "-"
        }
    }
    
    public var categoryText: String {
        let set = category as? Set<Category> ?? []
        let array = [Category](set)
        let mappedArray = array.map{ $0.wrappedName }
        if mappedArray.count > 0 {
            return mappedArray.joined(separator: "、")
        } else {
            return "-"
        }
    }

}

// MARK: Generated accessors for author
extension Book {

    @objc(addAuthorObject:)
    @NSManaged public func addToAuthor(_ value: Author)

    @objc(removeAuthorObject:)
    @NSManaged public func removeFromAuthor(_ value: Author)

    @objc(addAuthor:)
    @NSManaged public func addToAuthor(_ values: NSSet)

    @objc(removeAuthor:)
    @NSManaged public func removeFromAuthor(_ values: NSSet)

}

// MARK: Generated accessors for category
extension Book {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}

extension Book : Identifiable {

}
