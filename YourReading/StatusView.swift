//
//  StatusView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/28.
//

import SwiftUI

struct StatusView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var selectedStatus = "未閱讀"
    @State private var isReadEnd = true
    let books: FetchedResults<Book>
    let statusOptions = ["已閱讀", "正在閱讀", "未閱讀"]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("選擇狀態", selection: $selectedStatus) {
                        ForEach(statusOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.clear)
                
                Section("\(selectedStatus)清單") {
                    ForEach(readingList) { book in
                        HStack(spacing: 10) {
                            Group {
                                AsyncImage(url: book.wrappedThumbnail) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } else if phase.error != nil {
                                        Text("圖片載入失敗")
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(height: 60, alignment: .leading)
                            }
                            .frame(width: 50)

                            VStack(alignment: .leading) {
                                Text(book.titleText)
                                    .font(.headline.weight(.medium))
                                Text(book.authorText)
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                            }

                        }
                        .swipeActions {
//                            if book.isReadEnd != true {
                            if selectedStatus != "已閱讀" {
                                Button {
                                    markBookStatus(book)
                                } label: {
                                    Text(swipeButtonText)
                                }
                                .tint(.orange)
                            }
                            
                        }
                        
                    }
                }
//                .headerProminence(.increased)
            }
//            .listStyle(.insetGrouped)
            .navigationTitle("閱讀狀態")
        }
    }
    
    var swipeButtonText: String {
        if selectedStatus == "未閱讀" {
            return "開始閱讀"
        } else if selectedStatus == "正在閱讀" {
            return "已閱讀"
        } else {
            return ""
        }
    }
    
    var readingList: [Book] {
        switch selectedStatus {
        case "已閱讀":
            return books.filter { $0.isReadEnd == true }
        case "正在閱讀":
            return books.filter { $0.isReadEnd == false }
        case "未閱讀":
            return books.filter { $0.isReadEnd == nil }
        default:
            return []
        }
    }
    
    func markBookStatus(_ book: Book) {
        withAnimation {
            if book.isReadEnd == nil {
                book.setValue(Date.now, forKey: "startRead")
                book.setValue(false, forKey: "isReadEnd")
            } else if book.isReadEnd == false {
                book.setValue(Date.now, forKey: "endRead")
                book.setValue(true, forKey: "isReadEnd")
            } else {
                return
            }
            
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

//struct StatusView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatusView()
//    }
//}
