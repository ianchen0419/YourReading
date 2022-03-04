//
//  ContentView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/20.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showAddBookSheet = false
    var books: FetchedResults<Book>
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(books, id: \.self) { book in
                            NavigationLink {
                                BookDetailView(book: book)
                            } label: {
                                AsyncImage(url: book.wrappedThumbnail) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .shadow(color: Color.black.opacity(0.2), radius: 0.5, x: 0, y: 1.5)
                                            .shadow(color: Color.black.opacity(0.14), radius: 1, x: 0, y: 1)
                                            .shadow(color: Color.black.opacity(0.12), radius: 2.5, x: 0, y: 0.5)
                                    } else if phase.error != nil {
                                        Text("圖片載入失敗")
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(minHeight: 100)

                            }
                        }
                        
                        Button {
                            showAddBookSheet = true
                        } label: {
                            VStack {
                                Image(systemName: "plus")
                                    .font(.title)
                                Text("新增書籍")
                                    .padding(.top)
                                    .font(.subheadline)
                            }
                        }
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, minHeight: proxy.size.width * 0.4)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(.secondary, style: StrokeStyle(lineWidth: 1.5, dash: [6])))
                    }
                    .padding()
                }
            }
            .background(.systemGray6)
            .navigationTitle("首頁")
            .sheet(isPresented: $showAddBookSheet) {
                AddBookView()
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static let book = Book()
//    static var previews: some View {
//        HomeView(book: book)
//    }
//}
