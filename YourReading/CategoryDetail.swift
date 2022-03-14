//
//  CategoryDetail.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/3/1.
//

import SwiftUI

struct CategoryDetail: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var showDeleteAlert = false
    @State private var editMode: EditMode = .inactive
    @State private var showAddBookSheet = false
    
    let category: Category
    let books: FetchedResults<Book>
    
    var booksNotInCategory: [Book] {
//        let allBooks = category.bookList
        let results = books.filter {
            category.bookList.contains($0) == false
        }
        
        return results
    }
    
    var body: some View {
        List {
            Section {
                ForEach(category.bookList) { book in
//                    Text(book.titleText)
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        Text(book.titleText)
                    }
                }
                .onDelete(perform: removeBook)
            }
            
            if booksNotInCategory.count > 0 {
                Section {
                    ListButtonView(text: "加入書籍", color: .blue) {
                        showAddBookSheet = true
                    }
                }
            }
            
            Section {
                ListButtonView(text: "刪除這個書單", color: .red) {
                    showDeleteAlert = true
                }
            }
            
        }
        .navigationTitle(category.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(editMode == .inactive ? "編輯" : "完成") {
                withAnimation {
                    if editMode == .inactive {
                        editMode = .active
                    } else {
                        editMode = .inactive
                    }
                }
            }
        }
        .alert("刪除書單", isPresented: $showDeleteAlert) {
            Button("刪除", role: .destructive, action: deleteCategory)
            Button("取消", role: .cancel, action: { })
        } message: {
            Text("確定刪除「\(category.wrappedName)」書單嗎")
        }
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $showAddBookSheet) {
            CategoryAddBook(category: category, booksNotInCategory: booksNotInCategory)
        }
    }
    
    func removeBook(at offsets: IndexSet) {
        for index in offsets {
            let book = category.bookList[index]
            category.removeFromBook(book)
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    func deleteCategory() {
        moc.delete(category)
        if moc.hasChanges {
            try? moc.save()
            dismiss()
        }
    }
}

//struct CategoryDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryDetail()
//    }
//}
