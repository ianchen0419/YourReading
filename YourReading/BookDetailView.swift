//
//  BookDetailView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/21.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showDeleteAlert = false
    
    let book: Book

    var body: some View {
        GeometryReader { proxy in
            List {
                Section {
                    HStack {
                        Spacer()
                        AsyncImage(url: book.wrappedThumbnail) { phase in
                            if let image = phase.image {
                                HStack {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(color: Color.black.opacity(0.2), radius: 0.5, x: 0, y: 1.5)
                                        .shadow(color: Color.black.opacity(0.14), radius: 1, x: 0, y: 1)
                                        .shadow(color: Color.black.opacity(0.12), radius: 2.5, x: 0, y: 0.5)
                                }
                            } else if phase.error != nil {
                                Text("圖片載入失敗")
                            }
                            else {
                                HStack {
                                    ProgressView()
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .accessibilityLabel("封面")
                        
                        Spacer()
                    }
                    .frame(height: proxy.size.height * 0.6)
                }
                .listRowInsets(.init(top: 3, leading: 0, bottom: 3, trailing: 0))
                .listRowBackground(Color.clear)
                
                Section {
                    ListRowView(title: "書名", content: book.titleText)
                    ListRowView(title: "ISBN", content: book.isbn_13Text)
                    ListRowView(title: "作者", content: book.authorText)
                    ListRowView(title: "所屬書單", content: book.categoryText)
                    ListRowView(title: "出版日期", content: book.publishedDateText)
                    ListRowView(title: "狀態", content: book.readStatusText)
                    ListRowView(title: "閱讀開始日", content: book.startReadText)
                    ListRowView(title: "閱讀結束日", content: book.endReadText)
                }
                
                ListButtonView(text: "刪除", color: .red) {
                    showDeleteAlert = true
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(book.titleText)
            .navigationBarTitleDisplayMode(.inline)
            .alert("刪除書籍", isPresented: $showDeleteAlert) {
                Button("刪除", role: .destructive) {
                    moc.delete(book)
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }
                Button("取消", role: .cancel) { }
            } message: {
                Text("確定刪除「\(book.titleText)」嗎？")
            }
        }
    }
}

//struct BookDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookDetailView()
//    }
//}
