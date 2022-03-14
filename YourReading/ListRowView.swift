//
//  ListRow.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/21.
//

import SwiftUI

struct ListRowView: View {
    let title: String
    let content: String?
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(content ?? "-")
                .foregroundColor(.secondary)
        }
        .accessibilityElement()
        .accessibilityLabel(title)
        .accessibilityHint(content ?? "無")
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(title: "書名", content: "青くて痛くて脆い")
            .previewLayout(.sizeThatFits)
    }
}
