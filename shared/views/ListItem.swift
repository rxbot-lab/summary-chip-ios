//
//  ListItem.swift
//  summary-chip
//
//  Created by Qiwei Li on 6/30/24.
//

import SwiftUI

struct ListItem: View {
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ListItem(title: "Hello", description: "World")
}
