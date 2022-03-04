//
//  ListButtonView.swift
//  YourReading
//
//  Created by Yi An Chen on 2022/2/21.
//

import SwiftUI

struct ListButtonView: View {
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(text)
                Spacer()
            }
        }
        .foregroundColor(color)
    }
}

struct ListButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ListButtonView(text: "刪除", color: .red, action: {})
            .previewLayout(.sizeThatFits)
    }
}
