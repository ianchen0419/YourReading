//
//  AddView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/27.
//

import SwiftUI

struct Response: Codable {
    var items: [Item]
}

struct Item: Codable {
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    var title: String
    var description: String
    var publishedDate: Date
    var imageLinks: ImageLinks
    var authors: [String]
    var industryIdentifiers: [IndustryIdentifiers]
}

struct ImageLinks: Codable {
    var smallThumbnail: String
    var thumbnail: String
}

struct IndustryIdentifiers: Codable {
    var type: String
    var identifier: String
}


struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    @State private var items = [Item]()
    
    var body: some View {
        NavigationView {
            if text.count > 0 {
                List {
                    Section("ISBN 查詢結果") {
                        ForEach(items, id: \.volumeInfo.title) { item in
                            Button {
                                saveBook(item.volumeInfo)
                            } label: {
                                Text(item.volumeInfo.title)
                            }
                            .foregroundColor(.primary)
                        }
                        .task {
                            await searchBook(text)
                        }
                        
                    }
                    
                }
            } else {
                VStack {
                    Image(systemName: "barcode")
                            .foregroundColor(.secondary)
                            .font(.system(size: 100))
                            .navigationTitle("新增書籍")
                            .navigationBarTitleDisplayMode(.inline)
                    Text("加入書籍開始記錄閱讀狀態")
                        .foregroundColor(.secondary)
                        .padding(.top)
                }
            }
            
        }
        .searchable(text: $text, prompt: "請輸入 ISBN 13 碼") {
            
        }
        .onChange(of: text) {
            let param = $0
            Task {
                await searchBook(param)
            }
        }
        .keyboardType(.numberPad)
        
    }
    
    func saveBook(_ bookItem: VolumeInfo) {
        
        let url = bookItem.imageLinks.thumbnail
        let replacedUrl = url.replacingOccurrences(of: "http", with: "https")
        
        var index = 0
        while bookItem.industryIdentifiers[index].type != "ISBN_13" {
            index += 1
        }
        
        print(bookItem.publishedDate)
        
        let bookObj = Book(context: moc)
        bookObj.detail = bookItem.description
        bookObj.isbn_13 = bookItem.industryIdentifiers[index].identifier
        bookObj.title = bookItem.title
        bookObj.publishedDate = bookItem.publishedDate
        bookObj.thumbnail = URL(string: replacedUrl)

        for author in bookItem.authors {
            let authorObj = Author(context: moc)
            authorObj.name = author
            bookObj.addToAuthor(authorObj)
        }

        if moc.hasChanges {
            try? moc.save()
            dismiss()
        }
        

    }
    
    func searchBook(_ isbn: String) async {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM"
            decoder.dateDecodingStrategy = .formatted(formatter)
            if let decodedResponse = try? decoder.decode(Response.self, from: data) {
                items = decodedResponse.items
            }
            
            formatter.dateFormat = "y-MM-DD"
            if let decodedResponse2 = try? decoder.decode(Response.self, from: data) {
                items = decodedResponse2.items
            }
        } catch {
            print("Invalid data")
        }
            
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
