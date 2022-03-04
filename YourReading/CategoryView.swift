//
//  CategoryView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/28.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showAddCategory = false
    let categories: FetchedResults<Category>
    let books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            List(categories) { category in
                NavigationLink {
//                    CategoryDetail()
                    CategoryDetail(category: category, books: books)
                } label: {
                    Text(category.wrappedName)
                }
            }
            .navigationTitle("我的書單")
            .toolbar {
                Button("新增") {
                   showAddCategory = true
                }
            }
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView(books: books)
            }
        }
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
