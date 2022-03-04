//
//  AppView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/27.
//

import SwiftUI

struct AppView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.startRead, order: .reverse),
    ]) var books: FetchedResults<Book>
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date, order: .reverse),
    ]) var categories: FetchedResults<Category>
    
    var body: some View {
        TabView {
            HomeView(books: books)
                .tabItem {
                    Image(systemName: "house")
                    Text("首頁")
                }
            
            StatusView(books: books)
                .tabItem {
                    Image(systemName: "book")
                    Text("狀態")
                }
            
            CategoryView(categories: categories, books: books)
                .tabItem {
                    Image(systemName: "heart")
                    Text("我的書單")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
