//
//  AddCategoryView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/28.
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var editMode: EditMode = .active
    @State private var selectedBooks = Set<Book>()
    @State private var categoryTitle = ""
    @FocusState private var categoryTitleFocused: Bool
    
    let books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            List(selection: $selectedBooks) {
                Section("書單名稱") {
                    TextField("請輸入", text: $categoryTitle)
                        .focused($categoryTitleFocused)
                }
                
                Section("選擇要加入的書籍") {
                    ForEach(books, id: \.self) { book in
                        HStack {
                            Text(book.titleText)
                        }
                    }
                }
            }
            .navigationTitle("新增書單")
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("完成") { categoryTitleFocused = false }
                    }
                }
            }
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
                .disabled(categoryTitle.isEmpty)
            }
        }
    }
}

//struct AddCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            AddCategoryView()
//        }
//    }
//}
