//
//  CategoryAddBook.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/3/3.
//

import SwiftUI

struct CategoryAddBook: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var editMode: EditMode = .active
    @State private var selectedBooks = Set<Book>()
    let category: Category
    let booksNotInCategory: [Book]
    
    var body: some View {
        NavigationView {
            List(booksNotInCategory, id: \.self, selection: $selectedBooks) { book in
                Text(book.titleText)
            }
            .environment(\.editMode, $editMode)
            .navigationTitle("加入書籍")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("完成") {
                    let nsSet = selectedBooks as NSSet
                    category.addToBook(nsSet)
                    if moc.hasChanges {
                        try? moc.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

//struct CategoryAddBook_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryAddBook()
//    }
//}
