//
//  SelectBookView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/3/1.
//

import SwiftUI

struct SelectBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
//    @Environment(\.editMode) var editMode
    @State private var editMode: EditMode = .active
    @State private var selectedBooks = Set<Book>()
    let books: FetchedResults<Book>
    let categoryTitle: String
    
    var body: some View {
        List(books, id: \.self, selection: $selectedBooks) { book in
            Text(book.titleText)
        }
        .navigationTitle("選擇書籍")
        .toolbar {
            Button("建立") {
                let category = Category(context: moc)
                category.name = categoryTitle
                let nsSet = selectedBooks as NSSet
                category.addToBook(nsSet)
                if moc.hasChanges {
                    try? moc.save()
                    dismiss()
                }
            }
//            EditButton()
        }
        .environment(\.editMode, $editMode)
    }
}

//struct SelectBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectBookView()
//    }
//}
